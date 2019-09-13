require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  Pry.start
  require 'irb'
  ARGV.clear
  IRB.start
end




