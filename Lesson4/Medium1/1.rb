class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Ben is right. He can write balance on line 9 because
# it's actually using a getter method as created
# on line 2
# If line 2 wasn't there, Alyssa would've been right.