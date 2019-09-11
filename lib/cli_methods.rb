require 'rest-client'
require 'json'
require 'pry'

#station = ""

def greet
    puts "Welcome to MartaFinder, the command line solution to for your MARTA train-finding needs!"
end

def prompt
    puts "Please enter a station name: "
end

def get_station
    station = gets.chomp
    binding.pry
end

def print_statiton_info(station)
    puts "You have requested info on station: #{station}"
end



