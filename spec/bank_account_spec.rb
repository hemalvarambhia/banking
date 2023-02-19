describe 'Bank Account' do
  example 'opening a bank account with zero balance' do
    pending('TODO')
    bank_account = BankAccount.new(starting_balance: 0)
    expected_statement = ['Date Amount Balance', "#{Date.today} 0 0"].join("\n")
    expect(bank_account.print_statement).to eq(expected_statement)
  end

  example 'opening a bank account with an initial deposit'

  example 'cannot open a bank account with a negative initial deposit'
end