# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ShowUp::Application.initialize!

# Load the default title. Er ma gerd
APP_CONFIG = YAML.load_file("#{Rails.root}/config/title.yml")
