require 'resque/tasks'

task "resque:setup" => :environment do
  ENV['QUEUE'] = '*'
end

Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection } #many connections or smthing
desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"
