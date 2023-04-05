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

  def statement_lines
    @transactions.to_enum.with_index.map do |t, number|
      running_total = compute_running_total_up_to(number)
      print_transaction(t) + " " + "#{running_total}"
    end.join("\n")
  end

  def print_statement
    column_titles = 'Date Amount Balance'
    if @transactions.empty?
      column_titles
    else
      [
        column_titles,
        "#{print_transaction(@transactions.last)} #{current_balance}"
      ].join("\n")
    end
  end

  private

  def compute_running_total_up_to(number)
    @transactions[0..number].inject(0) { |sum, transaction| sum + transaction.amount }
  end

  def overdrawn_past_overdraft_limit?(amount)
    current_balance - amount < @overdraft_limit
  end

  def print_transaction(transaction)
    "#{transaction.date.strftime('%d.%m.%Y')} #{transaction.amount}"
  end
end
