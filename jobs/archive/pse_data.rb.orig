require 'puppet_forge'
require 'pry'

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
end

forge_a = [ "dylanratcliffe", "jesse", "benjaminrobertson" ]  # All user names hat have forge modules should be added to this array

SCHEDULER.every '2s' do                 # The application will check for new data on a daily basis

    forge_a.each do | username |
        find_user(username)             # The username is passed to each method
        find_module(username)
    end
end


