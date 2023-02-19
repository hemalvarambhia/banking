require 'date'
class BankAccount
  def initialize(starting_balance:)
    @initial_balance = 0
  end

  def print_statement
    'Date Amount Balance'
  end
end
describe 'Bank Account' do
  example 'opening a bank account with zero balance' do
    bank_account = BankAccount.new(starting_balance: 0)

    statement = bank_account.print_statement

    expected_statement = 'Date Amount Balance'
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with an initial deposit' do
    pending('TODO')
    bank_account = BankAccount.new(starting_balance: 20)

    statement = bank_account.print_statement

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 20 20"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'cannot open a bank account with a negative initial deposit'
end