require 'date'
require 'transaction'
require 'money'
BankAccountSetUpIncorrectly = Class.new(StandardError)
class BankAccount
  include Enumerable

  def initialize(initial_deposit:, overdraft_limit: -2000)
    raise BankAccountSetUpIncorrectly.new('Cannot open with a negative deposit') if initial_deposit < 0
    @overdraft_limit = Money.new(overdraft_limit.to_f)
    @transactions = []
    @transactions << Transaction.new(date: Date.today, value: Money.new(initial_deposit.to_f)) if initial_deposit > 0
  end

  def each(&block)
    @transactions.each(&block)
  end

  def deposit(amount, monetary_amount)
    raise StandardError.new('Cannot deposit a negative amount') if monetary_amount < Money.new(0)

    @transactions << Transaction.new(date: Date.today, value: monetary_amount) if amount > 0
  end

  def withdraw(amount)
    raise StandardError.new('Cannot withdraw a negative amount of money') if amount < 0
    raise StandardError.new('Account is past its overdraft limit') if overdrawn_past_overdraft_limit?(Money.new(amount))

    @transactions << Transaction.new(date: Date.today, value: Money.new(-amount.to_f))
  end

  def current_balance
    Money.new(
      inject(0){ |sum, transaction| sum + transaction.amount }
    )
  end

  def running_total_up_to(number)
    Money.new(
      @transactions[0..number].inject(0) { |sum, transaction| sum + transaction.amount }
    ).value
  end

  private

  def overdrawn_past_overdraft_limit?(amount)
    (current_balance + Money.new(-amount.value)) < @overdraft_limit
  end
end
