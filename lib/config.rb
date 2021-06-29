# This class manages the loading, validation and helper methods associated with
# forge module config. This means that each job shouldn't need to handle the
# config manually each time. If we want to make changes to the structure of the
# config file they can be made here without having to edit all of the code
#
class PSEConfig
  def initialize(path = 'config.yaml')
    @config = YAML.load_file(path)

    # Check that the config is valid and raise an error if not
    config_valid?

    @users  = @config['users']
  end

  # Returns all raw user data
  def users
    return @users
  end

  # Returns an array of all forge usernames
  def forge_usernames
    return users.map { |u| u['forge_username'] }.compact # compact removes nil values
  end

  # Returjns an array of all gem names
  def gems
    all_gems = []

    users.each do |user|
      all_gems << user['gems']
    end

    return all_gems.flatten.compact
  end

  private
  
  def config_valid?
    # Make sure that we have been passed an array of users
    raise 'users key not an array' unless @config['users'].is_a? Array
  end
end