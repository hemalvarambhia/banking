require_relative '../lib/money'
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
      bank_account.deposit(5.00, Money.new(5.00))

      bank_statement = BankStatement.new(bank_account)
      statement_lines = bank_statement.lines

      expect(statement_lines).to eq(["#{Date.today.strftime('%d.%m.%Y')} 5.00 5.00"])
    end

    example 'two deposit transactions' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.deposit(5.00, Money.new(5.00))
      bank_account.deposit(5.00, Money.new(5.00))

      bank_statement = BankStatement.new(bank_account)
      statement_lines = bank_statement.lines

      expected = [
        "#{Date.today.strftime('%d.%m.%Y')} 5.00 5.00",
        "#{Date.today.strftime('%d.%m.%Y')} 5.00 10.00"
      ]
      expect(statement_lines).to eq(expected)
    end

    example 'one deposit is made followed by one withdrawal' do
      bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
      bank_account.deposit(50.00, Money.new(50.00))
      bank_account.withdraw(5.00)

      bank_statement = BankStatement.new(bank_account)
      statement_lines = bank_statement.lines

      expected = [
        "#{Date.today.strftime('%d.%m.%Y')} 50.00 50.00",
        "#{Date.today.strftime('%d.%m.%Y')} -5.00 45.00"
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
        "#{Date.today.strftime('%d.%m.%Y')} -12.50 -12.50",
        "#{Date.today.strftime('%d.%m.%Y')} -5.75 -18.25"
      ]
      expect(statement_lines).to eq(two_withdrawals)
    end
  end

  example 'when only one deposit is made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.deposit(50.00, Money.new(50.00))

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    with_one_deposit =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 50.00 50.00"
      ].join("\n")
    expect(statement).to eq(with_one_deposit)
  end

  example 'when only one withdrawal is made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.withdraw(50.00)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    with_one_withdrawal =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} -50.00 -50.00"
      ].join("\n")
    expect(statement).to eq(with_one_withdrawal)
  end

  example 'when two deposits are made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.deposit(5.00, Money.new(5.00))
    bank_account.deposit(10.00, Money.new(10.00))

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    with_two_deposits =
      [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 5.00 5.00",
        "#{Date.today.strftime('%d.%m.%Y')} 10.00 15.00"
      ].join("\n")
    expect(statement).to eq(with_two_deposits)
  end

  example 'when two withdrawals are made' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.withdraw(51.00)
    bank_account.withdraw(11.00)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    two_withdrawals = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} -51.00 -51.00",
      "#{Date.today.strftime('%d.%m.%Y')} -11.00 -62.00"
    ].join("\n")
    expect(statement).to eq(two_withdrawals)
  end

  example 'when a deposit is followed by a withdrawal' do
    bank_account = BankAccount.new(initial_deposit: 0, overdraft_limit: -2000)
    bank_account.deposit(512.00, Money.new(512.00))
    bank_account.withdraw(11.00)

    bank_statement = BankStatement.new(bank_account)
    statement = bank_statement.print

    one_deposit_and_then_withdrawal = [
      'Date Amount Balance',
      "#{Date.today.strftime('%d.%m.%Y')} 512.00 512.00",
      "#{Date.today.strftime('%d.%m.%Y')} -11.00 501.00"
    ].join("\n")
    expect(statement).to eq(one_deposit_and_then_withdrawal)
  end
end