require 'date'  
require_relative "checksplitter.rb"
require_relative "event.rb"
 
class DinnerClub

  #events - Array of Event objects
  attr_reader :events, :name
  
  
  #
  # returns events as an empty array
  def initialize(name)
    @events = []
    @name = name
  end
  
  #Updates members_and_their_balances hash after an event
  #Adds event to the events Array
  #
  #Options - Hash of the items needed for an event - must have attendees and final_bill
  #
  #       :attendees   - Array of attendee names - some members may not be in attendance
  #       :payees      - Array of those who will pay (optional)
  #       :final_bill  - Float of final bill
  #       :location    - String of location of event, defaulting to "not provided" if not provided (optional)
  #       :date - Date - Date of the event, defaulting to today's date if not provided (optional)
  #       :tip_percent - Float of tip percentage (optional)
  #
  #Returns events
  def add_event(args)
    this_event = get_event_object(args)
    save_event(this_event)
    events
  end

  #Deletes an event from the Array
  #
  #Options - Hash of the items needed for an event - must have attendees and final_bill
  #
  #       :attendees   - Array of attendee names - some members may not be in attendance
  #       :payees      - Array of those who will pay (optional)
  #       :final_bill  - Float of final bill
  #       :location    - String of location of event, defaulting to "not provided" if not provided (optional)
  #       :date - Date - Date of the event, defaulting to today's date if not provided (optional)
  #       :tip_percent - Float of tip percentage (optional)
  #
  #Returns events
  def delete_event(args)
    this_event = get_event_object(args)
    remove_event(this_event)
  end
  
  #gets a persons balance from all outings
  #
  #name - String - member's name
  #
  #returns Float of member's balance 
  def get_members_balance(name)
    balance = 0
    events.each do |event|
      if event.payees.include?(name)
        balance += get_each_person_split(event)
      end
    end
    balance
  end
  
  #gets Array of all members
  #
  #returns an Array of all the members
  def get_member_list
    members = []
    events.each do |event|
      event.attendees.each do |attendee|
        members.push(attendee) unless members.include?(attendee)
      end
    end
    members
  end
  
  #gets each member's balance
  #
  #returns a hash of members and their balance
  def get_each_members_balance
    members = get_member_list
    balance = Hash.new(0)
    members.each do |member|
      balance[member] = get_members_balance(member)
    end
    balance
  end
  
  private
  #Saves event to the events array
  #
  #event is an Event object
  #
  #returns events array
  def save_event(event)
    @events.push(event)
  end
  #Removes event from the events array
  #
  #event is an Event object
  #
  #returns events array
  def remove_event(event)
    @events.delete(event)
  end
  #returns an event object (could be receiving an event object already; if not makes one from args)
  #
  #args - Hash of at least attendees and final_bill; may also have tip_percent, location, date, and payees
  #
  #returns event object
  def get_event_object(args)
    if args.is_a? Event
      this_event = args
    else
      this_event = Event.new(args)
    end
  end

  #gets each person's split using the CheckSplittler class
  #
  #event is an Event class object
  #
  #returns Float
  def get_each_person_split(event)
    check = CheckSplitter.new({size_of_party: event.attendees.length, bill_amount: event.bill_amount, 
      tip_percent: event.tip_percent})
    check.calculate_per_person_share(event.payees.length)
  end

end