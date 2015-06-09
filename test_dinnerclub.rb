require_relative "dinnerclub.rb"
require "minitest/autorun"

class DinnerClubTest < MiniTest::Test

  def test_initialize
    name = "name"
    dc = DinnerClub.new(name)
    
    #check initialization procedures
    assert_equal(name, dc.name)
    assert_equal([], dc.events)
  end


  def test_add_event_and_remove_event
    e = Event.new(attendees: ["wendy", "laurie"], bill_amount: 100, tip_percent: 100, location: "burger", date: "01-01-2015", payees: ["wendy"])
    
    #add the event and test
    dc = DinnerClub.new("name")
    dc.add_event(e)
    assert_equal(dc.events, [e])
    
    #and now delete it and see
    dc.delete_event(e)
    assert_equal(dc.events, [])
    dc.delete_event(e)
  end
  
  def test_members_balance_and_member_list
    # set up
    e = Event.new(attendees: ["wendy", "laurie"], bill_amount: 100, tip_percent: 100, location: "burger", date: "01-01-2015", payees: ["wendy"])
    f = Event.new(attendees: ["wendy", "laurie", "paul"], bill_amount: 100, tip_percent: 20, location: "burger", payees: ["wendy", "laurie"])
    
    #add the event and test
    dc = DinnerClub.new("name")
    dc.add_event(e)
    dc.add_event(f)
    
    # test methods
    assert_equal(260, dc.get_members_balance("wendy"))
    assert_equal(0, dc.get_members_balance("paul"))
    assert_equal(["wendy", "laurie", "paul"], dc.get_member_list)
    assert_equal({"wendy" => 260, "laurie" => 60, "paul" => 0}, dc.get_each_members_balance)  
  end
  
end