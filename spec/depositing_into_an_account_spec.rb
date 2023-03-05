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
  def initialize(initial_deposit:)
    raise BankAccountSetUpIncorrectly.new('Cannot open with a negative deposit') if initial_deposit < 0
    @initial_balance = initial_deposit
    @transaction = Transaction.new(date: Date.today, amount: initial_deposit)
  end

  def deposit(amount)

  end

  def current_balance
    @initial_balance
  end

  def print_statement
    column_titles = 'Date Amount Balance'
    if @initial_balance.zero?
      column_titles
    else
      [
        column_titles,
        "#{@transaction.to_s} #{@initial_balance}"
      ].join("\n")
    end
  end
end

describe 'Bank Account' do
  describe 'depositing into an account' do
    it 'does not increase the balance on the account with nothing is deposited' do
      account = BankAccount.new(initial_deposit: 50)

      account.deposit(0)

      expect(account.current_balance).to eq(50)
    end

    it 'increases the balance on the account when a non-zero amount is deposited'

    it 'does not allow a negative amount to be deposited into the account'
  end
end