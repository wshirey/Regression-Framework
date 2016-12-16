$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'rspec'
require 'watir-webdriver'
require 'faker'
require 'headless'




RSpec.configure do |config|
  Headless.new(display: 100, destroy_at_exit: false).start
  browser = Watir::Browser.new :firefox
  config.before(:all) { @browser = browser }
  #config.after(:suite) { browser.close }
end

