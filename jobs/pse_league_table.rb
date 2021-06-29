require 'puppet_forge'
require 'pry'
require 'yaml'
require_relative '../lib/config'

PuppetForge.user_agent = "PseForgeData" # par


def find_data(username)
    user = PuppetForge::User.find(username) # The Puppetforge::User object retrieves all data from the forge API
    count = user.module_count             # The module_count method returns the total number of modules for the user

    return ({label: username, value: count})  
end

config = PSEConfig.new
forge_a = config.forge_usernames

SCHEDULER.every '3600s', first: :now  do

    module_counts = []

    forge_a.each do | username |
        module_count = find_data(username)             
        module_counts << module_count
    end

    modules_by_order = module_counts.sort_by! { |x| -x[:value]}

    send_event('league_table', { items: modules_by_order })

end