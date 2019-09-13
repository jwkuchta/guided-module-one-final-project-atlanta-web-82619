require_relative '../config/environment'
require_relative '../lib/cli_methods'
require_relative '../lib/api_methods'
new_cli = CommandLineInterface.new
ActiveRecord::Base.logger = nil

#binding.pry
`reset`
new_cli.welcome
train_art
new_cli.login
`reset`
origin = new_cli.get_line.upcase
`reset`
# #origin = get_origin
sleep(0.5)
destination = new_cli.get_destination.split.map {|c| c.capitalize}.join(" ")
`reset`
sleep(0.5)
give_station_info(origin, destination)









