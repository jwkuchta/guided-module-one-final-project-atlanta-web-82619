class StationLine < ActiveRecord::Base
    belongs_to :line
    belongs_to :station
end 
   
#A line has many stations and a station has many lines, station_lines belongs to line and station