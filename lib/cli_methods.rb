require 'rest-client'
require 'json'
require 'pry'
require 'tty-prompt'
require 'tty-font'
require 'colorize'


class CommandLineInterface

    def welcome
        font = TTY::Font.new(:doom)
        pastel = Pastel.new
        puts pastel.yellow(font.write("Welcome to MartaFinder"))
        puts "A less ugly Marta app".blue
        puts "*****************************************************************************".light_cyan
    end

    def login
        prompt = TTY::Prompt.new
        login = prompt.select("Are you a registered user?".cyan, ["Yes, log me in", "No, create an account"])
        if login == "Yes, log me in"
          user_name = prompt.ask("Enter your username:")
        else
          name = prompt.ask("Enter your name:")
          user_name = prompt.ask("Choose username:")
          if User.find_by(username: user_name)
            user_name = prompt.ask("That username is taken. Please choose another.")
            User.create(name: name, username: user_name)
          else
            User.create(name: name, username: user_name)
          end
        end
        user = User.find_by(username: user_name)
        menu(user)
    end

    def menu(user)
        prompt = TTY::Prompt.new
        option = ["Find next train time", "Find all stations by line", "Add station review", 
        "Search my reviews", "Search all reviews by station", "Exit"]
        input = prompt.select("Hello #{user.username}! Please choose from the following options:".blue, option) 
        if input == "Find next train time"
            origin = CommandLineInterface.get_line
            destination = CommandLineInterface.get_destination
            give_station_info(origin, destination)
        elsif input == "Find all stations by line"
            line_options = ["Red Line", "Gold Line", "Blue Line", "Green Line", "Exit"]
            input = prompt.select("Please choose a line", line_options)
            if input == "Red Line"
                StationLine.print_red_line_stations
            elsif input == "Gold Line"
                StationLine.print_gold_line_stations
            elsif input == "Blue Line"
                StationLine.print_blue_line_stations
            elsif input == "Green Line"
                StationLine.print_green_line_stations
            elsif input == "Exit"
                exit
            end
        elsif input == "Add station review"
            all_stations = ['Airport', 'Arts Center', 'Ashby', 'Avondale', 'Bankhead', 'Brookhaven', 
            'Buckhead', 'Candler Park', 'Chamblee', 'Civic Center', 'College Park', 'Decatur', 'Doraville', 'Dunwoody', 
            'East Lake', 'East Point', 'Five Points', 'Garnett', 'Georgia State', 'GWCC/Mercedes-Benz Stadium', 
            'H.E. Holmes', 'Indian Creek', 'Inman Park/Reynoldstown', 'Kensington', 'King Memorial', 'Lakewood', 
            'Lenox', 'Lindbergh Center', 'Medical Center', 'Midtown', 'North Avenue', 'North Springs', 'Oakland City', 
            'Peachtree Center', 'Sandy Springs', 'Vine City', 'West End', 'West Lake']
            station = prompt.select("Please choose a station to review", all_stations)
            puts "Write your review: "
            review = gets.chomp
            Review.create(station_id: Station.all.find_by(name: station).id, review: review, user_id: user.id)
        elsif input == "Search my reviews"
            user.search_reviews
        elsif input == "Search all reviews by station"
            puts "Please enter a station name: "
            station_name = gets.chomp
            station_name = station_name.split.map {|c| c.capitalize}.join(" ")
            Review.review_by_station(station_name)
        elsif input == "Exit"
            exit
        end
        return self.menu(user)
    end

    def self.get_line
        prompt = TTY::Prompt.new
        line = prompt.select("Choose a line: ") do |menu|
            menu.choice "Red Line", -> {CommandLineInterface.red_line_info}
            menu.choice "Gold Line", -> {CommandLineInterface.gold_line_info}
            menu.choice "Blue Line", -> {CommandLineInterface.blue_line_info}
            menu.choice "Green Line", -> {CommandLineInterface.green_line_info}
            menu.choice "Exit", -> { exit }
        end
        line
    end

    def self.get_destination
        prompt = TTY::Prompt.new
        line = prompt.select("Choose destination: ") do |menu|
            menu.choice "Red Line", -> {CommandLineInterface.red_line_destinations}
            menu.choice "Gold Line", -> {CommandLineInterface.gold_line_destinations}
            menu.choice "Blue Line", -> {CommandLineInterface.blue_line_destinations}
            menu.choice "Green Line", -> {CommandLineInterface.green_line_destinations}
            menu.choice "Exit", -> { exit }
        end
        line
    end

    def self.red_line_info
        prompt = TTY::Prompt.new
        all_stations = ["North Springs", "Sandy Springs", "Dunwoody", "Medical Center", "Buckhead", 
        "Lindbergh Center", "Arts Center", "Midtown", "North Avenue", "Civic Center", "Peachtree Center", 
        "Five Points", "Garnett", "West End", "Oakland City", "Lakewood/Ft. McPherson", "East Point", 
        "College Park", "Airport"] 
        final_stations = ["North Springs", "Airport"]
        input = prompt.select("Choose a station: ", all_stations) 
        return input
    end

    def self.red_line_destinations
        prompt = TTY::Prompt.new 
        final_stations = ["North Springs", "Airport"]
        input = prompt.select("Choose a station: ", final_stations) 
        return input
    end

    def self.gold_line_info
        prompt = TTY::Prompt.new
        all_stations = ["Doraville", "Chamblee", "Brookhaven", "Lenox", "Lindbergh Center", "Arts Center", 
        "Midtown", "North Avenue", "Civic Center", "Peachtree Center", "Five Points", "Garnett", "West End"]
        final_stations = ["Doraville", "Airport"]
        input = prompt.select("Choose a station: ", all_stations)
        return input
    end

    def self.gold_line_destinations
        prompt = TTY::Prompt.new
        final_stations = ["Doraville", "Airport"]
        input = prompt.select("Choose a station: ", final_stations)
        return input
    end

    def self.blue_line_info
        prompt = TTY::Prompt.new
        all_stations = ["Hamilton E. Holmes", "West Lake", "Ashby", "Vine City", "Dome", 
        "Five Points", "Georgia State", "King Memorial", "Inman Park", "Edgewood", "East Lake", 
        "Decatur", "Avondale", "Kensington", "Indian Creek"]
        final_stations = ["Hamilton E. Holmes", "Indian Creek"]
        input = prompt.select("Choose a station: ", all_stations)
        return input
    end

    def self.blue_line_destinations
        prompt = TTY::Prompt.new
        final_stations = ["Hamilton E. Holmes", "Indian Creek"]
        input = prompt.select("Choose a station: ", final_stations)
        return input
    end

    def self.green_line_info
        prompt = TTY::Prompt.new
        all_stations = ["Bankhead", "Ashby", "Vine City", "Dome", "Five Points", "Georgia State", 
        "King Memorial", "Inman Park", "Edgewood"]
        final_stations = ["Bankhead", "Edgewood"]
        input = prompt.select("Choose a station: ", all_stations)
        return input
    end

    def self.green_line_destinations
        prompt = TTY::Prompt.new
        final_stations = ["Bankhead", "Edgewood"]
        input = prompt.select("Choose a station: ", final_stations)
        return input
    end
end


    


