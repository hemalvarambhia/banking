require 'date'
class BankAccount
  def initialize(starting_balance: 0)
    @initial_balance = starting_balance
  end

  def print_statement
    if @initial_balance.zero?
      'Date Amount Balance'
    else
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} #{@initial_balance} #{@initial_balance}"
      ].join("\n")
    end
  end
end
describe 'Bank Account' do
  example 'opening a bank account with zero balance' do
    bank_account = BankAccount.new

    statement = bank_account.print_statement

    expected_statement = 'Date Amount Balance'
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with an initial deposit' do
    bank_account = BankAccount.new(starting_balance: 20)

    statement = bank_account.print_statement

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 20 20"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with any initial deposit' do
    bank_account = BankAccount.new(starting_balance: 111)

    statement = bank_account.print_statement

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 111 111"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'cannot open a bank account with a negative initial deposit'
end