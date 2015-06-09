require "minitest/autorun"
require_relative "event.rb"
require 'date'

class EventTest < Minitest::Test
  
  def test_initialize
    attendees = ["wendy", "laurie", "susan"]
    payees = ["wendy", "roger"]
    e = Event.new(attendees: attendees, location: "Burger King", bill_amount: 100)
    assert_equal(100, e.bill_amount)
    assert_equal(attendees, e.attendees)
    assert_equal(attendees, e.payees)
    assert_equal(e.date, Date.today)
    assert_equal(e.location, "Burger King")
    
    dat = Date.parse("01-01-2015")
    
    f = Event.new(attendees: attendees, payees: payees, location: "Burger King", bill_amount: 100, date: "01-01-2015")
    

    
    assert_equal(100, f.bill_amount)
    assert_equal(attendees, f.attendees)
    assert_equal(payees, f.payees)
    assert_equal(f.date, dat)
    assert_equal(f.location, "Burger King")
  end
  
  
end

#
#
# require 'date'
#
# class Event
#
#   attr_reader :date, :attendees, :location, :bill_amount, :payees, :tip_percent
#
#   #options -  Hash of initialize values
#   #
#   #           :date         - Date, defaulting to today (optional)
#   #           :attendees    - Array of names of those who attended
#   #           :payees       - Array of the names of those who will pay (optional)
#   #           :location     - String of the location of the event (optional)
#   #           :bill_amount  - Float of the total bill
#   def initialize(args)
#     @attendees = args[:attendees]
#     @bill_amount = args[:bill_amount]
#     @tip_percent = args[:tip_percent]
#     if args[:payees].nil?
#        @payees = args[:attendees]
#     else
#       @payees = args[:payees]
#     end
#
#     set_location(args[:location])
#     set_date(args[:date])
#   end
#
#   private
#   #sets the location attribute
#   #
#   #location - String
#   #
#   #returns @location
#   def set_location(location)
#     if location.nil?
#       @location = "not provided"
#     else
#       @location = location
#     end
#   end
#
#   #sets the date
#   #
#   #date = should be a date, but if it is not, @date will be set to today's date
#   #
#   #returns @date (Date)
#   def set_date(date)
#     begin
#       Date.parse(date)
#       @date = date
#     rescue
#       @date = Date.today
#     end
#   end
# end