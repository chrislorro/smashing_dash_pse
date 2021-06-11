require 'puppet_forge'
PuppetForge.user_agent = "PseForgeData"

now = Date.today
start_date = Date.new(now.year, now.month, 1)

@mods_download = PuppetForge::Module.where(owner: 'puppetlabs', sort_by: 'downloads', limit: 10)

my_hash = {}

@mods_download.each do | d | 

  name = d.name
  downloads = d.downloads
  
 my_hash[name] = downloads 
    
end

SCHEDULER.every '5m' do

    download_hash = my_hash.map do | name, value |
      ({label: name, value: value})
    end
    
    send_event('downloads', { items: download_hash })
end