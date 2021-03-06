$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'rspec'
require 'watir'
require 'page-object'
require 'page-object/page_factory'
require 'faker'
require 'pages'
require 'headless'

browser = Watir::Browser.new :firefox
browser.window.maximize

RSpec.configure do |config|
  Headless.new(display: 100, destroy_at_exit: false).start
  config.include PageObject::PageFactory
  config.before(:all) { @browser = browser }
  #config.after(:suite) { browser.close }
end
