require_relative '../lib/bank_account'
require_relative '../lib/bank_statement'

describe 'Bank Account' do
  example 'opening a bank account with zero balance' do
    bank_account = BankAccount.new(initial_deposit: 0)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    expected_statement = 'Date Amount Balance'
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with an initial deposit' do
    bank_account = BankAccount.new(initial_deposit: 20)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 20 20"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with any initial deposit' do
    bank_account = BankAccount.new(initial_deposit: 111)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 111 111"
    ].join("\n")
    expect(statement).to eq(expected_statement)
  end

  example 'opening a bank account with any initial deposit that is not a whole amount' do
    bank_account = BankAccount.new(initial_deposit: 111.12)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

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