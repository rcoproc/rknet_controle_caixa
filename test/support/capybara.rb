require 'capybara'
require 'capybara/rails'

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  fixtures :all

end
