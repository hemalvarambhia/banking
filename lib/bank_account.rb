require 'date'
require 'transaction'
BankAccountSetUpIncorrectly = Class.new(StandardError)
class BankAccount
  attr_reader :transactions
  def initialize(initial_deposit:, overdraft_limit: -2000)
    raise BankAccountSetUpIncorrectly.new('Cannot open with a negative deposit') if initial_deposit < 0
    @overdraft_limit = overdraft_limit
    @transactions = []
    @transactions << Transaction.new(date: Date.today, amount: initial_deposit) if initial_deposit > 0
  end

  def deposit(amount)
    raise StandardError.new('Cannot deposit a negative amount') if amount < 0

    @transactions << Transaction.new(date: Date.today, amount: amount) if amount > 0
  end

  def withdraw(amount)
    raise StandardError.new('Cannot withdraw a negative amount of money') if amount < 0
    raise StandardError.new('Account is past its overdraft limit') if overdrawn_past_overdraft_limit?(amount)

    @transactions << Transaction.new(date: Date.today, amount: -amount)
  end

  def current_balance
    @transactions.inject(0){ |sum, transaction| sum + transaction.amount }
  end

  def no_transactions?
    @transactions.empty?
  end

  def bank_statement_lines
    @transactions.map.with_index do |transaction, number|
      print_transaction(transaction) + " " + "#{running_total_up_to(number)}"
    end
  end

  def running_total_up_to(number)
    @transactions[0..number].inject(0) { |sum, transaction| sum + transaction.amount }
  end

  def print_transaction(transaction)
    "#{transaction.date.strftime('%d.%m.%Y')} #{transaction.amount}"
  end

  private

  def overdrawn_past_overdraft_limit?(amount)
    current_balance - amount < @overdraft_limit
  end
end
