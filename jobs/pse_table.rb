require 'puppet_forge'
require 'pry'

PuppetForge.user_agent = "PseForgeData" # parameter is required when making API calls on the forge


def find_user(username)
    totals = 0
    usrid = username
    user = PuppetForge::User.find(username) # The Puppetforge::User object retrieves all data from the forge API
    modules = user.module_count             # The module_count method returns the total number of modules for the user
    release = user.release_count            # The release_count returns the total number of releases for a user
   
    hrows = [
        { cols: [ {value: 'Contributor'}, {value: 'Downloads'}, {value: 'User mods'}, {value: 'User release'} ] }
    ]

    rows = [
        { cols: [ {value: usrid}, {value: 'undef'}, {value: modules}, {value: release} ]},
    ]

   send_event('my-table', { hrows: hrows, rows: rows } )
end

forge_a = [ "puppetlabs", "dylanratcliffe", "jesse", "benjaminrobertson" ]  # All user names hat have forge modules should be added to this array

SCHEDULER.every '2s' do                 # The application will check for new data on a daily basis

    forge_a.each do | username |
        find_user(username)             # The username is passed to each method
       # find_module(username)
    end
end