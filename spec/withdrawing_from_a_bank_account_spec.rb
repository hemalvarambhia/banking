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

  example 'withdrawing a negative amount from a bank account'

  example 'becoming overdrawn'
end