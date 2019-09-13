class Line < ActiveRecord::Base
    has_many :stations, through: :station_lines
    has_many :station_lines
end 
   

#A line has many stations and a station has many lines, station_lines belongs to line and station