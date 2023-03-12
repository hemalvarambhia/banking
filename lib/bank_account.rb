require 'date'
class Transaction
  attr_reader :amount
  def initialize(date:, amount:)
    @date = date
    @amount = amount
  end

  def to_s
    "#{@date.strftime('%d.%m.%Y')} #{@amount}"
  end
end
BankAccountSetUpIncorrectly = Class.new(StandardError)
class BankAccount
  def initialize(initial_deposit:)
    raise BankAccountSetUpIncorrectly.new('Cannot open with a negative deposit') if initial_deposit < 0
    @transactions = []
    @transactions << Transaction.new(date: Date.today, amount: initial_deposit) if initial_deposit > 0
  end

  def deposit(amount)
    raise StandardError.new('Cannot deposit a negative amount') if amount < 0

    @transactions << Transaction.new(date: Date.today, amount: amount) if amount > 0
  end

  def withdraw(amount)

  end

  def current_balance
    @transactions.inject(0){ |sum, transaction| sum + transaction.amount }
  end

  def print_statement
    column_titles = 'Date Amount Balance'
    if @transactions.empty?
      column_titles
    else
      [
        column_titles,
        "#{@transactions.last.to_s} #{@transactions.last.amount}"
      ].join("\n")
    end
  end
end
