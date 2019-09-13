class Station < ActiveRecord::Base
    has_many :lines, through: :station_lines
    has_many :station_lines
    has_many :users, through: :reviews
    has_many :reviews
end 
   