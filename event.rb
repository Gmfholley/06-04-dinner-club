require 'date'
require_relative 'marvel_api.rb'

class Event
  
  attr_reader :date, :attendees, :location, :bill_amount, :payees, :tip_percent, :marvel_character_name
  
  #options -  Hash of initialize values
  #
  #           :date         - Date, defaulting to today (optional)
  #           :attendees    - Array of names of those who attended
  #           :payees       - Array of the names of those who will pay (optional)
  #           :location     - String of the location of the event (optional)
  #           :bill_amount  - Float of the total bill
  #           :marvel_movie_name  - String of a marvel movie name (optional)
  def initialize(args)
    @attendees = args[:attendees]
    @bill_amount = args[:bill_amount]
    @tip_percent = args[:tip_percent]
    if args[:payees].nil?
       @payees = args[:attendees]
    else
      @payees = args[:payees]
    end
    
    set_location(args[:location])
    set_date(args[:date])
    set_marvel_character_name(args[:marvel_character_name])
  end

  private
  #sets the location attribute
  #
  #location - String
  #
  #returns @location
  def set_location(location)
    if location.nil?
      @location = "not provided"
    else
      @location = location
    end
  end
  
  #sets the date
  #
  #date = should be a date, but if it is not, @date will be set to today's date
  #
  #returns @date (Date)
  def set_date(date)
    begin
      @date = Date.parse(date)
    rescue
      @date = Date.today
    end
  end
  
  def set_marvel_character_name(try_movie)
    if !try_movie.nil?
      m_api = MarvelAPI.new
      result_arry = m_api.character_search(try_movie)
      if result_arry.length == 1
        @marvel_character_name = try_movie
      else
        @marvel_character_name = nil
      end
    end
  end
end