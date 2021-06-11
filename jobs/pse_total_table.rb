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

    return { cols: [ {value: usrid}, {value: totals}, {value: count}, {value: release} ]} # returns a row of user data collected from the forge. Format: Username, Total Downloads, Module Count, Release Count

end

forge_a = [ "puppetlabs", "dylanratcliffe", "jesse", "benjaminrobertson" ]  # All user names hat have forge modules should be added to this array

last_total_downloads = 0

SCHEDULER.every '900s', first: :now  do

    hrows = [
        { cols: [ {value: 'Contributor'}, {value: 'Downloads'}, {value: 'User mods'}, {value: 'User release'} ] }
    ]

    rows = []
    all_totals = []
    team_modules = []

    forge_a.each do | username |
        row = find_user(username)             
        rows << row
        all_totals << row[:cols][1][:value]
        team_modules << row[:cols][2][:value]
    end

    # binding.pry

    
    send_event('team-table', { hrows: hrows, rows: rows })
    send_event('all_downloads', { current: all_totals.sum })
    send_event('team_module_count', { current: team_modules.sum })
    send_event('user_downloads', { current:  all_totals.sum, last: last_total_downloads})
    
    last_total_downloads = all_totals.sum

end
