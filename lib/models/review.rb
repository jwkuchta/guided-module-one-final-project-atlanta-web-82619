class Review < ActiveRecord::Base
    belongs_to :user
    belongs_to :station

    def self.review_by_station(station_name)
        puts "Here are all reviews for #{station_name} Station: ".blue
        id = Station.all.find_by(name: station_name).id
        #binding.pry
        Review.all.where(station_id: id).each do |review|
            puts "********************************************************************************".cyan
            puts "#{review.review}".cyan
        end
    end
    `reset`
end 