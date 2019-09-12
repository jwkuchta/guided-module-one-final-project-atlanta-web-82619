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
  var = gets.chomp.split.map {|e| e.capitalize}.join(" ")
  if var == ""
    puts "Enter something, cuck!"
    get_destination
  end
  var
end

def add_review
  puts "Would you like to write a review even though you haven't taken this train yet lol?"
  input = gets.chomp.downcase
  if input == "yes" || input == "y"
    puts "Do you already have an account with us?"
    input = gets.chomp.downcase
    if input == "yes" || input == "y"
      puts "What is your username?"
      username = gets.chomp.downcase
      if User.find_by(username: username) && username == User.find_by(username: username).username
        puts "We found your account."
        puts "Please write your review."
        review = gets.chomp
        Review.create(review: review, user_id: User.find_by(username: username).id)
        puts "Your review has been added."
        # TODO: association with User
        # start from beginning
      else
        puts "Sorry, we can't find your account."
        add_review
      end
    else
      puts "What do you want your username to be?"
      try_again
    end
  end
end

def try_again
  new_username = gets.chomp.downcase
  user = User.find_by(username: new_username)
  if user && new_username == user.username
    puts "That username has been claimed. Choose another."
    try_again
  end
  User.create(username: new_username)
  puts "Your new account name is #{new_username}"
  puts "Please write your review."
  review = gets.chomp
  Review.create(review: review, user_id: User.find_by(username: new_username).id)
  # start from beginning
end
