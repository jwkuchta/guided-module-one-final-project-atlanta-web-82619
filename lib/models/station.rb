class Station < ActiveRecord::Base
    has many :lines, through: :station_line
end 
   
#A line has many stations and a station has many lines, station_lines belongs to line and station