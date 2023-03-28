require 'date'
require 'transaction'
BankAccountSetUpIncorrectly = Class.new(StandardError)
class BankAccount
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

  def transaction_lines
    @transactions.to_enum.with_index.map do |t, _|
      running_total = @transactions.inject(0){ |sum, transaction| sum + transaction.amount }
      t.to_s + " " + "#{running_total}"
    end.join
  end

  def print_statement
    column_titles = 'Date Amount Balance'
    if @transactions.empty?
      column_titles
    else
      [
        column_titles,
        "#{@transactions.last.to_s} #{current_balance}"
      ].join("\n")
    end
  end

  private

  def overdrawn_past_overdraft_limit?(amount)
    current_balance - amount < @overdraft_limit
  end
end
