# Dinner Club

A dinner club is a group of members who go out to dinner together.  Over time, we needed to keep track of each member's balance and a list of all the events.

The way I decided to keep track of this is to capture all events of the dinner club (attendees, payees, bill, tip, location, date).  The array of events is DinnerClub's only parameter.  To get information on the members, I loop through the events to get information on members.

When a dinner club is initalized, the array of Events is initialized to 0.  You do not need to pass any arguments into the Dinner Club.

```ruby
  def initialize()
    @events = []
  end
```

You can add events to the club, either using the arguments needed for an Event object, or passing an Event object itself.
```ruby
  def add_event(args)
    this_event = get_event_object(args)
    save_event(this_event)
    events
  end
```
get_event_object will either create the event object if it is not already passed as args or send it back if it is already an event object.
save_event saves the event into the events Array.
These two methods are utility methods.  I only mention them so that the user knows that they have flexibility about how they pass parameters to add_event.

The user can call the following public methods to get information about members:
 - get_members_balance (name)     --> takes a string of "name" and returns a float of their balance
 - get_member_list                --> returns an Array of all members from all events
 - get_each_members_balance       --> returns a Hash of all members and their balance 
 
 These three methods all loop through the array @events to get the information requested.  get_each_members_balance calls get_member_list and get_members_balance to construct its Hash.
 
 Behind the scenes, DinnerClub is calling a helper class, CheckSplitter, to split the check among the number of payees.
 
 ## Event
 
 The event class keeps track of each of the dinner club's events.
  - attendees     --> Array of names of attendees
  - bill_amount   --> Float of the bill
  - tip_percent   --> Integer of the tip (if already in decimal form, will be converted by CheckSplitter)
  - payees        --> Array of names of those who pay - defaults to the same as attendees if not provided
  - location      --> String of the location  - defaults to "not provided" if not provided
  - date          --> Date object - defaults to today if not provided
  
 ```ruby
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
 end
 ```
 
 Event's methods are mainly to set default values for the arguments.  I considered making it a struct, but the initializing methods were handy.  I also considered calling CheckSplitter directly from Events.  But I decided to let DinnerClub handle it because then DinnerClub is responsible for knowing about both CheckSplitter and Events.  There's less chance that DinnerClub breaks because I change the Events class or CheckSplitter later.
 
 ### CheckSplitter
 
 CheckSplitter takes three parameters:
  - size_of_party --> Integer, or if not an integer, will be set to 1
  - bill_amount   --> Float of the bill - or if not a float, will be set to 0
  - tip_percent   --> Integer of the tip - defaults to 18
 
 ```ruby
 def initialize (args)
   set_size_party(args[:size_of_party])
   set_bill_amount(args[:bill_amount])
   args[:tip_percent].nil? ? set_tip_percent : set_tip_percent(args[:tip_percent])
   nil
 end
 ```
 
 The set_size_party, set_bill_amount, and set_tip_percent are utility methods to set default values or correct for incorrectly inputted values.  For example, size_of_party is set to 1 if a user passes a value that is a string or 0, so that the calculation of each_persons_split is not infinity.
 
 The user will probably only use the calculate_per_person_share method.  num_persons, if not provided, defaults to the size_of_party but can be set to another value (for example, to accommodate a party who treats a birthday girl).  
 
 calculate_per_person_share calls a utility method, calculate_total, that has calcualted the final bill + tip.  calculate_per_person_share returns a Float rounded to two decimals.
 
 ```ruby
 #Calculates each person's share
 #
 #num_persons - Integer representing how many people split the check
 #
 #returns Float, rounded to two decimals
 def calculate_per_person_share (num_persons = @size_of_party)
   (calculate_total / num_persons).round(2)
 end
 ```