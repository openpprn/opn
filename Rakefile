# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

load 'tasks/emoji.rake'

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks



########################################
### CAPYBARA INTEGRATION BROWSER-SIMULATION TESTING
########################################

#Add the following to your Rakefile or a file in lib/tasks to add a rake task for running feature tests:
Rails::TestTask.new("test:features" => "test:prepare") do |t|
  t.pattern = "test/features/**/*_test.rb"
end

#If you want your new task to be run when you run rake test, also add the following:
Rake::Task["test:run"].enhance ["test:features"]