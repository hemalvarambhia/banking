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

  example 'becoming overdrawn'

  it 'writes the withdrawal transaction to the bank statement'
end