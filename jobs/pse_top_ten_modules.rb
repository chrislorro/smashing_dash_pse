require 'puppet_forge'
require 'pry'
require 'yaml'

PuppetForge.user_agent = "PseForgeData" # parameter is required when making API calls on the forge

def find_user_modules(username)
    module_array = []
    modules = PuppetForge::Module.where(owner: username) # The object will be used to return all user module data
    modules.unpaginated.map do | mod |     # unpaginated results allow us to work with all module data on a single page
        username = mod.owner.username 
        name = mod.name            # The data retrieved from the methods are collected in each parameter
        downloads = mod.downloads  # each method are related to parameters retrieved from the Forge API  
        module_array << {
            name: name,
            downloads: downloads,
            username: username
        }
    end
   # binding.pry
    return module_array
end

data = YAML.load_file "config.yaml"     # Load the config.yaml file
forge_a = data["user_list"]             # Find the key user_list and load the user list into the forge_a array

SCHEDULER.every '2s' do                 # The application will check for new data on a daily basis

    team_modules = []

    forge_a.each do | username |
        team_modules << find_user_modules(username)
    end

    # Flatten multi-dimentional array to be one-dimensional
    team_modules.flatten!
    team_modules.sort_by! { |x| -x[:downloads] }
    top_modules = team_modules.first(10)
    binding.pry

end