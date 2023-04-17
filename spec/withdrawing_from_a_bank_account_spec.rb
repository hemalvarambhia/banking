require_relative '../lib/bank_account'
require_relative '../lib/bank_statement'

describe 'Withdrawing from a bank account' do
  example 'withdrawing nothing from a bank account' do
    account = BankAccount.new(initial_deposit: 45)

    account.withdraw(0)

    expect(account.current_balance).to eq(45)
  end

  example 'withdrawing an amount from a bank account' do
    account = BankAccount.new(initial_deposit: 0)

    account.deposit(100)
    account.withdraw(50)

    expect(account.current_balance).to eq(50)
  end

  example 'withdrawing a negative amount from a bank account' do
    account = BankAccount.new(initial_deposit: 0)

    expect { account.withdraw(-131) }.to raise_error('Cannot withdraw a negative amount of money')
  end

  example 'becoming overdrawn' do
    overdrawn_account = BankAccount.new(initial_deposit: 100, overdraft_limit: -2000)

    overdrawn_account.withdraw(200)

    expect(overdrawn_account.current_balance).to eq(-100)
  end

  example 'becoming overdrawn past the overdraft limit' do
    overdrawn_account = BankAccount.new(initial_deposit: 100, overdraft_limit: -50)

    expect { overdrawn_account.withdraw(200) }.to raise_error('Account is past its overdraft limit')
  end

  it 'writes the withdrawal transaction to the bank statement' do
    account = BankAccount.new(initial_deposit: 100)

    account.withdraw(50)

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 100 100",
      "#{Date.today.strftime('%d.%m.%Y')} -50 50"
    ].join("\n")
    bank_statement = BankStatement.new(account)
    expect(bank_statement.print).to eq(expected_statement)
  end
end