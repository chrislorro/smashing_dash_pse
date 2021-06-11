require 'puppet_forge'
require 'pry'
require 'yaml'

PuppetForge.user_agent = "PseForgeData" # par


def find_data(username)
    user = PuppetForge::User.find(username) # The Puppetforge::User object retrieves all data from the forge API
    count = user.module_count             # The module_count method returns the total number of modules for the user

    return ({label: username, value: count})  
end

data = YAML.load_file "config.yaml"     # Load the config.yaml file
forge_a = data["user_list"]             # Find the key user_list and load the user list into the forge_a array

SCHEDULER.every '3600s', first: :now  do

    module_counts = []

    forge_a.each do | username |
        module_count = find_data(username)             
        module_counts << module_count
    end

    send_event('top-contrib', { items: module_counts })

end