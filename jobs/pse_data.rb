require 'puppet_forge'
require 'pry'
require 'yaml'

PuppetForge.user_agent = "PseForgeData" # parameter is required when making API calls on the forge

=begin
The find_user method will leverage the Puppetforge object, the user
modules, and number of releases are retrieved and the data passed
to other paramters in the smashing application.
=end

def find_user(username)
    usrid = username[0..2]
    user = PuppetForge::User.find(username) # The Puppetforge::User object retrieves all data from the forge API
    modules = user.module_count             # The module_count method returns the total number of modules for the user
    release = user.release_count            # The release_count returns the total number of releases for a user

    send_event("#{usrid}-mods", { current: modules }) # send_event parameter passes data to pse_dash.erb file
    send_event("#{usrid}-rels", { current: release }) # and is recieved with the data-id field.
end

=begin
The find_module method retrieves data related to each module the user has
submitted to the forge, the module information is passed to the dashboard
and diplayed in rank order, also the total number of downloads are calculated
and displayed on the dashboard application
=end

def find_user_modules(username)
    module_hash = {}
    modules = PuppetForge::Module.where(owner: username) # The object will be used to return all user module data
    modules.unpaginated.map do | mod |     # unpaginated results allow us to work with all module data on a single page
        username = mod.owner.username 
        name = mod.name            # The data retrieved from the methods are collected in each parameter
        downloads = mod.downloads  # each method are related to parameters retrieved from the Forge API  
        module_hash[name] = {
            downloads: downloads,
            username: username
        }
    end
    return module_hash
end


data = YAML.load_file "config.yaml"     # Load the config.yaml file
forge_a = data["user_list"]             # Find the key user_list and load the user list into the forge_a array

#SCHEDULER.every '2s' do                 # The application will check for new data on a daily basis

    #team_module_hash = {}
    #forge_a.each do | username |
    #    team_module_hash << find_module(username)
    #end
    team_module_hash = {}

    forge_a.each do | username |
        team_module_hash.merge!(find_user_modules(username))
    end
    
    binding.pry
    puts team_module_hash

#end