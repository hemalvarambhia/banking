describe 'Printing bank statements' do
  context 'statement lines' do
    example 'when no transactions were made' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)

      transaction_lines = bank_account.statement_lines

      with_no_deposits = ""
      expect(transaction_lines).to eq(with_no_deposits)
    end

    example 'a single deposit transaction' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.deposit(5)

      transaction_lines = bank_account.statement_lines

      with_two_deposits = "#{Date.today.strftime('%d.%m.%Y')} 5 5"

      expect(transaction_lines).to eq(with_two_deposits)
    end

    example 'two deposit transactions' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.deposit(5)
      bank_account.deposit(5)

      transaction_lines = bank_account.statement_lines

      with_two_deposits = "#{Date.today.strftime('%d.%m.%Y')} 5 5\n#{Date.today.strftime('%d.%m.%Y')} 5 10"

      expect(transaction_lines).to eq(with_two_deposits)
    end
  end

  example 'when only one deposit is made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.deposit(50)

    statement = bank_account.print_statement

    with_one_deposit =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 50 50"
      ].join("\n")
    expect(statement).to eq(with_one_deposit)
  end

  example 'when only one withdrawal is made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.withdraw(50)

    statement = bank_account.print_statement

    with_one_withdrawal =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} -50 -50"
      ].join("\n")
    expect(statement).to eq(with_one_withdrawal)
  end

  example 'when two deposits are made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.deposit(5)
    bank_account.deposit(10)

    statement = bank_account.print_statement

    with_two_deposits =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 5 5",
        "#{Date.today.strftime('%d.%m.%Y')} 10 15"
      ].join("\n")
    expect(statement).to eq(with_two_deposits)
  end

  example 'when two withdrawals are made'

  example 'when a deposit is followed by a withdrawal'
end