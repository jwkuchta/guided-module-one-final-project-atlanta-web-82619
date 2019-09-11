require 'rest-client'
require 'json'
require 'pry'

def destination_list(origin)
  response_string = RestClient.get("http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=4d22f269-2012-46ed-9243-2243357c468e")
  response_hash = JSON.parse(response_string)

  found = response_hash.select {|result| result["STATION"].include?(origin)}.map {|result| result["DESTINATION"]}.uniq.join(", ")
  puts "Choose a destination: #{found}"
end

def get_from_api(origin, destination)
  response_string = RestClient.get("http://developer.itsmarta.com/RealtimeTrain/RestServiceNextTrain/GetRealtimeArrivals?apikey=4d22f269-2012-46ed-9243-2243357c468e")
  response_hash = JSON.parse(response_string)

  train_info = response_hash.find {|result| result["STATION"].include?(origin) && result["DESTINATION"].include?(destination)}

  if train_info
    next_train = train_info["NEXT_ARR"]
    time_until = train_info["WAITING_SECONDS"]
    wait_time = train_info["WAITING_TIME"]
    direction = train_info["DIRECTION"]
    line = train_info["LINE"].capitalize

    case direction
    when "N"
      direction = "North"
    when "E"
      direction = "East"
    when "S"
      direction = "South"
    when "W"
      direction = "West"
    end

    if wait_time == "Boarding"
      puts "Hurry, your train is now boarding! Take the #{line} Line headed #{direction}! If you miss it, your next train arrives at #{next_train}."
    elsif wait_time == "Arriving"
      puts "Your train is arriving in #{time_until} seconds. Take the #{line} Line headed #{direction}."
    else
      if wait_time == "1 min"
        puts "Your train arrives in #{wait_time}. Take the #{line} Line headed #{direction}."
      else
        puts "Your train arrives in #{wait_time}s. Take the #{line} Line headed #{direction}."
      end
    end
  else
    puts "Sorry, that route doesn't exist."
    get_destination
  end

end
