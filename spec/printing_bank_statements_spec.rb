require_relative '../lib/bank_account'
require_relative '../lib/bank_statement'

describe 'Printing bank statements' do
  context 'statement lines' do
    example 'when no transactions were made' do
      bank_statement = BankStatement.new(
        BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      )

      statement_lines = bank_statement.lines

      expect(statement_lines).to be_empty
    end

    example 'a single deposit transaction' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.deposit(5)

      bank_statement = BankStatement.new(bank_account)
      statement_lines = bank_statement.lines

      expect(statement_lines).to eq(["#{Date.today.strftime('%d.%m.%Y')} 5 5"])
    end

    example 'two deposit transactions' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.deposit(5)
      bank_account.deposit(5)

      bank_statement = BankStatement.new(bank_account)
      statement_lines = bank_statement.lines

      expected = [
        "#{Date.today.strftime('%d.%m.%Y')} 5 5",
        "#{Date.today.strftime('%d.%m.%Y')} 5 10"
      ]
      expect(statement_lines).to eq(expected)
    end

    example 'one deposit is made followed by one withdrawal' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.deposit(50)
      bank_account.withdraw(5)

      bank_statement = BankStatement.new(bank_account)
      statement_lines = bank_statement.lines

      expected = [
        "#{Date.today.strftime('%d.%m.%Y')} 50 50",
        "#{Date.today.strftime('%d.%m.%Y')} -5 45"
      ]
      expect(statement_lines).to eq(expected)
    end

    example 'two withdrawal transactions' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.withdraw(12.50)
      bank_account.withdraw(5.75)

      bank_statement = BankStatement.new(bank_account)
      statement_lines = bank_statement.lines

      two_withdrawals = [
        "#{Date.today.strftime('%d.%m.%Y')} -12.5 -12.5",
        "#{Date.today.strftime('%d.%m.%Y')} -5.75 -18.25"
      ]
      expect(statement_lines).to eq(two_withdrawals)
    end
  end

  example 'when only one deposit is made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.deposit(50)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

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

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

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

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    with_two_deposits =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 5 5",
        "#{Date.today.strftime('%d.%m.%Y')} 10 15"
      ].join("\n")
    expect(statement).to eq(with_two_deposits)
  end

  example 'when two withdrawals are made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.withdraw(51)
    bank_account.withdraw(11)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    two_withdrawals = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} -51 -51",
      "#{Date.today.strftime('%d.%m.%Y')} -11 -62"
    ].join("\n")
    expect(statement).to eq(two_withdrawals)
  end

  example 'when a deposit is followed by a withdrawal' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.deposit(512)
    bank_account.withdraw(11)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    one_deposit_and_then_withdrawal = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 512 512",
      "#{Date.today.strftime('%d.%m.%Y')} -11 501"
    ].join("\n")
    expect(statement).to eq(one_deposit_and_then_withdrawal)
  end
end