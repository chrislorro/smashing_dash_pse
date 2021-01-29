require 'puppet_forge'
require 'pry'

PuppetForge.user_agent = "PseForgeData"

def find_user(username)
    usrid = username[0..2]
    user = PuppetForge::User.find(username)
    modules = user.module_count
    release = user.release_count

    send_event("#{usrid}-mods", { current: modules })
    send_event("#{usrid}-rels", { current: release })
end

def find_module(username)
    module_hash = {}
    usrid = username[0..2]
    totals = 0
    modules = PuppetForge::Module.where(owner: username)
    modules.unpaginated.map do | mods |
        name = mods.name
        downloads = mods.downloads
        totals = totals + downloads
        module_hash[name] = downloads
    end
    last_totals = totals
    download_hash = module_hash.map do | name, value |
        ({label: name, value: value})
    end
    send_event( "#{usrid}-dld", { items: download_hash })
    send_event( "#{usrid}-tot", { current: totals, last: last_totals })
end

forge_a = [ "dylanratcliffe", "jesse" ]

SCHEDULER.every '1d' do

    forge_a.each do | username |
        find_user(username)
        find_module(username)
    end
end


