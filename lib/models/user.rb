require 'colorize'

class User < ActiveRecord::Base
    # belongs_to :line
    # belongs_to :station
    has_many :reviews
    has_many :stations, through: :reviews

    def search_reviews
        self.reviews.each do |review|
            station_id = review.station_id
            station_name = Station.all.find_by(id: station_id)
            puts "********************************************************************************".blue
            puts "Your review for *#{station_name.name}* is: *#{review.review}*".cyan
            puts "********************************************************************************".blue
            sleep(0.5)
        end  
    end
end 


   
#A line has many stations and a station has many lines, station_lines belongs to line and station