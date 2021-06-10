require 'puppet_forge'
require 'pry'

PuppetForge.user_agent = "PseForgeData" # parameter is required when making API calls on the forge


def find_user(username)
    usrid   = username
    user    = PuppetForge::User.find(username) # The Puppetforge::User object retrieves all data from the forge API
    count = user.module_count             # The module_count method returns the total number of modules for the user
    release = user.release_count            # The release_count returns the total number of releases for a user

    modules = PuppetForge::Module.where(owner: username) 

    # Add all the numbers together using reduce
    totals = modules.unpaginated.reduce(0) do | sum, mod |                   
        sum + mod.downloads
    end

    return { cols: [ {value: usrid}, {value: totals}, {value: count}, {value: release} ]}

end

forge_a = [ "puppetlabs", "dylanratcliffe", "jesse", "benjaminrobertson" ]  # All user names hat have forge modules should be added to this array

SCHEDULER.every '10s' do

    hrows = [
        { cols: [ {value: 'Contributor'}, {value: 'Downloads'}, {value: 'User mods'}, {value: 'User release'} ] }
    ]

    rows = []

    forge_a.each do | username |
        row = find_user(username)             
        rows << row
    end

    send_event('my-table', { hrows: hrows, rows: rows })

end