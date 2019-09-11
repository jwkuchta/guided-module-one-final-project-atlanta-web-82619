require 'rest-client'
require 'json'
require 'pry'

def greet
    puts "Welcome to MartaFinder, the command line solution for your MARTA train-finding needs!"
end

def get_origin
  puts "Please enter your origin station."
  gets.chomp.upcase
end

def get_destination
  var = gets.chomp.split.map { |e| e.capitalize }.join(" ")
  if var == ""
    puts "Enter something, cuck!"
    get_destination
  end
  var
end
