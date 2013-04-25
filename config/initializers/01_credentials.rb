require 'credentials_config'

CredentialsConfig.config = YAML.load_file('config/credentials.yml')[Rails.env].symbolize_keys