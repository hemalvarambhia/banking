require_relative '../lib/money'
require_relative '../lib/bank_account'
require_relative '../lib/bank_statement'

describe 'Withdrawing from a bank account' do
  example 'withdrawing nothing from a bank account' do
    account = BankAccount.new(initial_deposit: 45.00)

    account.withdraw(0.0, monetary_amount: Money.new(0.00))

    expect(account.current_balance.to_f).to eq(45.00)
  end

  example 'withdrawing an amount from a bank account' do
    account = BankAccount.new(initial_deposit: 0)

    account.deposit_money(Money.new(100))
    account.withdraw(50, monetary_amount: Money.new(50.00))

    expect(account.current_balance.to_f).to eq(50)
  end

  example 'withdrawing a negative amount from a bank account' do
    account = BankAccount.new(initial_deposit: 0)

    expect { account.withdraw(-131) }.to raise_error('Cannot withdraw a negative amount of money')
  end

  example 'becoming overdrawn' do
    overdrawn_account = BankAccount.new(initial_deposit: 100, overdraft_limit: -2000)

    overdrawn_account.withdraw(200, monetary_amount: Money.new(200.00))

    expect(overdrawn_account.current_balance.to_f).to eq(-100)
  end

  example 'becoming overdrawn past the overdraft limit' do
    overdrawn_account = BankAccount.new(initial_deposit: 100, overdraft_limit: -50)

    expect { overdrawn_account.withdraw(200, monetary_amount: Money.new(200.00)) }.to raise_error('Account is past its overdraft limit')
  end

  it 'writes the withdrawal transaction to the bank statement' do
    account = BankAccount.new(initial_deposit: 100.00)

    account.withdraw(50.00, monetary_amount: Money.new(50.00))

    expected_statement = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 100.00 100.00",
      "#{Date.today.strftime('%d.%m.%Y')} -50.00 50.00"
    ].join("\n")
    bank_statement = BankStatement.new(account)
    expect(bank_statement.print).to eq(expected_statement)
  end
end