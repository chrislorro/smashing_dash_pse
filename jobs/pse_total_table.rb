require 'puppet_forge'
require 'pry'
require 'yaml'
require_relative '../lib/config'

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

config = PSEConfig.new
forge_a = config.forge_usernames

 yaml_object = YAML.load_file("history.yml")
 last_total_downloads = YAML.load(yaml_object["user_downloads"])["data"]["last"]

#SCHEDULER.every '3600s', first: :now  do

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

    rows_by_downloads = rows.sort_by! { |x| -x[:cols][1][:value]}

    # binding.pry
    
    send_event('team-table', { hrows: hrows, rows: rows_by_downloads })
    send_event('team_module_count', { current: team_modules.sum })
    send_event('user_downloads', { current:  all_totals.sum, last: last_total_downloads})
    
    last_total_downloads = all_totals.sum

#end
