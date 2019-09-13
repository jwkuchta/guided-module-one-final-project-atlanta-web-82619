require 'rest-client'
require 'json'
require 'pry'
require 'colorize'

def give_station_info(origin, destination)
  #make the web request
  response_string = RestClient.get('http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=4d22f269-2012-46ed-9243-2243357c468e')
  response_hash = JSON.parse(response_string)
  origin = origin.split.map {|c| c.capitalize}.join(" ")
  destination = destination.split.map {|c| c.capitalize}.join(" ")

  #origin_station = origin_station.split.map {|c| c.capitalize}.join(" ")

  station_info = response_hash.find do |result| 
    result["STATION"].downcase.include?(origin.downcase) && result["DESTINATION"].downcase.include?(destination.downcase)
  end

  #binding.pry
  if station_info
    
    next_time = station_info["NEXT_ARR"]
    line = station_info["LINE"].downcase.capitalize
    wait_time = station_info["WAITING_TIME"]
    message = "Your train from #{origin} to #{destination} Station on #{line} Line".cyan
    if wait_time == "Arriving"
        puts "*****************************************************************************".light_cyan
        puts
        puts "#{message} is arriving.".cyan
        puts
        puts "*****************************************************************************".light_cyan
    elsif wait_time == "Boarding"
        puts "*****************************************************************************".light_cyan
        puts
        puts "#{message} is now boarding. Hurry!".cyan
        puts "*****************************************************************************".light_cyan
        puts
    else
        puts "*****************************************************************************".light_cyan
        puts
        puts "#{message} is arriving in #{wait_time}.".cyan
        puts
        puts "*****************************************************************************".light_cyan
    end
  else 
    puts "*****************************************************************************".light_cyan
    puts
    puts "We're sorry. There's no line connecting these two stations.".cyan
    puts
    puts "*****************************************************************************".light_cyan
  end
  #binding.pry
end

def train_art
  puts <<-'EOF'
  ___________   _______________________________________^__
   ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\
  |   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\
  |___| |___|||| |___| |___| |___|  | O | O | |  |  |        \
             |||                    |___|___| |  |__|         )
  ___________|||______________________________|______________/
  EOF
  puts
  puts "********************************************************************************".cyan
end

# def give_destinations(origin)
#     response_string = RestClient.get('http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=4d22f269-2012-46ed-9243-2243357c468e')
#     response_hash = JSON.parse(response_string)
#     origin = origin.split.map {|c| c.capitalize}.join(" ")


#give_station_info("MIDTOWN STATION", "Airport")






