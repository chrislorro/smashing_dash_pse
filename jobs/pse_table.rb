require 'puppet_forge'
require 'pry'

PuppetForge.user_agent = "PseForgeData" # parameter is required when making API calls on the forge


user = PuppetForge::User.find('puppetlabs')
current_modules = PuppetForge::Module.all.total
user_modules = user.module_count
release_count = user.release_count

def find_module(username)
    module_hash = {}
    usrid = username[0..2]      # The first 3 letters of a username is set to pass send_event data to the application
    totals = 0
    modules = PuppetForge::Module.where(owner: username) # The object will be used to return all user module data
    modules.unpaginated.map do | mods |     # unpaginated results allow us to work with all module data on a single page
        name = mods.name                    # The data retrieved from the methods are collected in each parameter
        downloads = mods.downloads          # each method are related to parameters retrieved from the Forge API 
        totals = totals + downloads 
        module_hash[name] = downloads
    end
    last_totals = totals
    download_hash = module_hash.map do | name, value |  # All data is consolidated into a hash value that is passed aas 
        ({label: name, value: value})                   # an event to the application 
    end
    send_event( "#{usrid}-dld", { items: download_hash }) 
    send_event( "#{usrid}-tot", { current: totals, last: last_totals }) # Total downloads can be used to track the number of daily downloads for each user

    rows = [
        { cols: [ {value: userid}, {value: download_hash}, {value: 'undef'}, {value: 'undef'} ]},
    ]
 
    send_event('my-table', { hrows: hrows, rows: rows } )
end

forge_a = [ "puppetlabs", "dylanratcliffe", "jesse", "benjaminrobertson" ]  # All user names hat have forge modules should be added to this array
hrows = [
    { cols: [ {value: 'Contributor'}, {value: 'Totals'}, {value: 'User mods'}, {value: 'User release'} ] }
]

SCHEDULER.every '2s' do                 # The application will check for new data on a daily basis

    forge_a.each do | username |
   #    find_user(username)             # The username is passed to each method
        find_module(username)
    end
end