require 'colorize'

class StationLine < ActiveRecord::Base
    belongs_to :line
    belongs_to :station

    def self.print_red_line_stations
        station_ids = StationLine.all.select {|l| l.line_id == 1}.map {|sl| sl.station_id}
        stations = Station.all.select {|s| station_ids.include?(s.id)}.map {|sl| sl.name}
        puts "*****************************************************************************".light_cyan
        puts "Here are all Red Line stations: ".cyan
        puts stations
        puts "*****************************************************************************".light_cyan
        #binding.pry
    end

    def self.print_gold_line_stations
        station_ids = StationLine.all.select {|l| l.line_id == 2}.map {|sl| sl.station_id}
        stations = Station.all.select {|s| station_ids.include?(s.id)}.map {|sl| sl.name}
        puts "*****************************************************************************".light_cyan
        puts "Here are all Gold Line stations: ".cyan
        puts stations
        puts "*****************************************************************************".light_cyan
    end

    def self.print_blue_line_stations
        station_ids = StationLine.all.select {|l| l.line_id == 3}.map {|sl| sl.station_id}
        stations = Station.all.select {|s| station_ids.include?(s.id)}.map {|sl| sl.name}
        puts "*****************************************************************************".light_cyan
        puts "Here are all Blue Line stations: ".cyan
        puts stations
        puts "*****************************************************************************".light_cyan
    end

    def self.print_green_line_stations
        station_ids = StationLine.all.select {|l| l.line_id == 4}.map {|sl| sl.station_id}
        stations = Station.all.select {|s| station_ids.include?(s.id)}.map {|sl| sl.name}
        puts "*****************************************************************************".light_cyan
        puts "Here are all Green Line stations: ".cyan
        puts stations
        puts "*****************************************************************************".light_cyan
    end
end 
   
#A line has many stations and a station has many lines, station_lines belongs to line and station

