require 'colorize'

class User < ActiveRecord::Base
    # belongs_to :line
    # belongs_to :station
    has_many :reviews
    has_many :stations, through: :reviews

    def search_reviews
        #binding.pry
        if self.reviews.length > 0
            self.reviews.each do |review|
                station_id = review.station_id
                station_name = Station.all.find_by(id: station_id)
                puts "********************************************************************************".cyan
                puts 
                puts "Your review for *#{station_name.name}* is: *#{review.review}*".blue
                puts
                puts "********************************************************************************".cyan
                sleep(0.5)
            end
        else
            puts "********************************************************************************".cyan
            puts
            puts "You don't have any reviews yet".blue
            puts
        end  
    end
end 


   
#A line has many stations and a station has many lines, station_lines belongs to line and station