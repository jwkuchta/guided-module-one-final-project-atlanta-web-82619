# require_relative '../config/environment'
require_relative '../lib/cli_methods'
require_relative '../lib/api_methods'

greet
origin = get_origin
destination_list(origin)
destination = get_destination
get_from_api(origin, destination)
