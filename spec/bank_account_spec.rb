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

  def print_statement
    transaction = Transaction.new(date: Date.today, amount: @initial_balance)
    if @initial_balance.zero?
      'Date Amount Balance'
    else
      [
        'Date Amount Balance',
        "#{@transaction.to_s} #{@initial_balance}"
      ].join("\n")
    end
  end
end
describe 'Bank Account' do
  example 'opening a bank account with zero balance' do
    bank_account = BankAccount.new(initial_deposit: 0)

    statement = bank_account.print_statement

    expected_statement = 'Date Amount Balance'
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with an initial deposit' do
    bank_account = BankAccount.new(initial_deposit: 20)

    statement = bank_account.print_statement

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 20 20"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with any initial deposit' do
    bank_account = BankAccount.new(initial_deposit: 111)

    statement = bank_account.print_statement

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 111 111"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with any initial deposit that is not a whole amount' do
    bank_account = BankAccount.new(initial_deposit: 111.12)

    statement = bank_account.print_statement

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 111.12 111.12"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'cannot open a bank account with a negative initial deposit' do
    expect { BankAccount.new(initial_deposit: -187) }.to raise_error(BankAccountSetUpIncorrectly, 'Cannot open with a negative deposit')
  end
end