require 'puppet_forge'
PuppetForge.user_agent = "PseForgeData"

user = PuppetForge::User.find('puppetlabs')
current_modules = PuppetForge::Module.all.total
user_modules = user.module_count
release_count = user.release_count

SCHEDULER.every '5m' do
  send_event('modules', { current: current_modules })
  send_event('usermods', { current: user_modules })
  send_event('release', { current: release_count })
end