require "minitest/autorun"
require_relative "checksplitter.rb"

class CheckSplitterTest < Minitest::Test
  # One of my specs is that the tip_amount method should blah blah blah.
  
  def test_initialize
    
    # checking for all good data
    check = CheckSplitter.new(size_of_party: 5, bill_amount: 87.50, tip_percent: 20)
    
    assert_equal(check.size_of_party, 5)
    assert_equal(check.bill_amount, 87.50)
    assert_equal(check.tip_percent, 20)
    
    
    # checking for bad or missing arguments
    check2 = CheckSplitter.new(size_of_party: "shari", bill_amount: "susan")
    
    assert_equal(check2.size_of_party, 1)
    assert_equal(check2.bill_amount, 0)
    assert_equal(check2.tip_percent, 18)
    
  end
  
  def test_calculate_tip
    check = CheckSplitter.new(size_of_party: 5, bill_amount: 100, tip_percent: 20)
    assert_equal(check.calculate_tip, 20)
  end
  
  
  def test_calculate_per_person_share s
    check = CheckSplitter.new(size_of_party: 5, bill_amount: 100, tip_percent: 20)
    #test for normal splitting of this check
    assert_equal(check.calculate_per_person_share, 24)
    #test if you send an optional argument (how many people should split)
    assert_equal(check.calculate_per_person_share(1), 120)
  end
  
  
  # Another spec is that the total_amount method should blah blah blah.
end