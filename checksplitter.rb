class CheckSplitter
  
  attr_reader :size_of_party, :bill_amount
  
  #options  - Hash of arguments
  #         :size_of_party  -  Integer or converted to Int of the size of the party
  #         :tip_percent    - Integer or converted to Int (optional)
  #         :bill_amount    - Float of the bill
  #
  #returns self
  def initialize (args)
    set_size_party(args[:size_of_party])
    set_bill_amount(args[:bill_amount])
    args[:tip_percent].nil? ? set_tip_percent : set_tip_percent(args[:tip_percent])
  end
  
  #Calculates each person's share
  #
  #num_persons - Integer representing how many people split the check
  #
  #returns Float, rounded to two decimals
  def calculate_per_person_share (num_persons = @size_of_party)
    (calculate_total / num_persons).round(2)
  end
  
  #Calculates the tip from bill_amount and tip_percent
  #
  #returns Float, rounded to two decimals
  def calculate_tip
    (bill_amount * @tip_percent / 100).round(2)
  end
  
  #Calculates total bill from bill_amount and calculate_tip
  #
  #returns a Float
  def calculate_total
    bill_amount + calculate_tip
  end

  private
  
  #sets @size_of_party
  #
  #size - should be an Integer > 0, but this method sets it to 1 if it is not
  #
  #returns size_of_party (int)
  def set_size_party(size)
    size = size.to_i
    #set to party size 1 to avoid division errors
    if size <= 1
      @size_of_party = 1
    else
      @size_of_party = size
    end
  end
  
  #sets @bill_amount
  #
  #amount - should be a float, but if it isn't, sets it to 0
  #
  #returns @bill_amount
  def set_bill_amount(amount)
    #non float amounts will be 0
    @bill_amount = amount.to_f
  end
  
  #sets @tip_percent
  #
  #tip - should be a float, but if it is not, sets tip to 0
  #
  #returns @tip_percent
  def set_tip_percent(tip = 18)
    #sets to 18% by default; if a decimal, multiplies by 100
    tip = tip.to_f
    if tip < 1
      @tip_percent = tip * 100 
    else
      @tip_percent = tip
    end
  end
end