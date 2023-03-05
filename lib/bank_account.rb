require 'date'
require 'ostruct'
class Transaction
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
  attr_reader :current_balance
  def initialize(initial_deposit:)
    raise BankAccountSetUpIncorrectly.new('Cannot open with a negative deposit') if initial_deposit < 0
    @current_balance = initial_deposit
    @transactions = [ Transaction.new(date: Date.today, amount: initial_deposit) ]
  end

  def deposit(amount)
    @current_balance = @current_balance + amount
  end

  def print_statement
    column_titles = 'Date Amount Balance'
    if @current_balance.zero?
      column_titles
    else
      [
        column_titles,
        "#{@transactions.first.to_s} #{@current_balance}"
      ].join("\n")
    end
  end
end
