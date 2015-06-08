require_relative "dinnerclub.rb"


members = ["Wendy", "Susan", "Nancy", "Delores"]

attendees_first_event = ["Wendy", "Susan", "Nancy"]

dc = DinnerClub.new()
puts "Here is my dc dining club: #{dc.inspect}"


first_event = Event.new(attendees: attendees_first_event, bill_amount: 100, tip_percent: 25)
puts "Here is my first event: #{first_event.inspect}"

puts "Now I will go out to my first event"
puts dc.add_event(first_event)


attendees_second_event = ["Wendy", "Stuart", "Doug"]
payees_second_event = ["Roger"]


second_event = Event.new(attendees: attendees_second_event, bill_amount: 125, payees: payees_second_event, tip_percent: 10)
puts "Now I will go out to my second event."
puts dc.add_event(second_event)

puts "Now I will go out to my third event, without creating an Event object"
puts dc.add_event(attendees: ["Roger", "Susan", "Doug"], bill_amount: 45,tip_percent: 14, location: "Olive Garden", payees: ["Susan", "Doug"])

puts "Finally, I will print all my event objects"

dc.events.each {|x| puts x.inspect}

puts "And now I will see if I can get member balance from just the events class"

puts "Susan: #{dc.get_members_balance("Susan")}"
puts "Doug: #{dc.get_members_balance("Doug")}"
puts "Roger: #{dc.get_members_balance("Roger")}"
puts "Does not exist: #{dc.get_members_balance("Does not exist")}"

puts "Now a list of all members: #{dc.get_member_list}"
puts "Now a list of all member balances :#{dc.get_each_members_balance}"