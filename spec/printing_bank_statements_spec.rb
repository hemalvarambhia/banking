describe 'Printing bank statements' do
  example 'when only one deposit is made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: 2000)
    bank_account.deposit(50)

    statement = bank_account.print_statement

    with_one_deposit =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 50 50"
      ].join("\n")
    expect(statement).to eq(with_one_deposit)
  end

  example 'when only one withdrawal is made'

  example 'when no transactions were made'

  example 'when two deposits are made'

  example 'when two withdrawals are made'

  example 'when a deposit is followed by a withdrawal'
end