require_relative '../lib/money'
require_relative '../lib/bank_account'
require_relative '../lib/bank_statement'

describe 'Bank Account' do
  describe 'depositing into an account' do
    it 'does not increase the balance on the account with nothing is deposited' do
      account = BankAccount.new(initial_deposit: 50.00)

      account.deposit(Money.new(0))

      expect(account.current_balance.to_f).to eq(50.00)
      expected_statement = [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 50.00 50.00"
      ].join("\n")
      bank_statement = BankStatement.new(account)
      expect(bank_statement.print).to eq(expected_statement)
    end

    it 'increases the balance on the account when a non-zero amount is deposited' do
      account = BankAccount.new(initial_deposit: 0)

      account.deposit(Money.new(50.00))

      expect(account.current_balance.to_f).to eq(50)
    end

    it 'writes the deposit transaction to the bank statement' do
      account = BankAccount.new(initial_deposit: 0)

      account.deposit(Money.new(50.00))

      expected_statement = [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 50.00 50.00"
      ].join("\n")
      bank_statement = BankStatement.new(account)
      expect(bank_statement.print).to eq(expected_statement)
    end

    it 'does not allow a negative amount to be deposited into the account' do
      account = BankAccount.new(initial_deposit: 0)

      expect { account.deposit(Money.new(-50.00)) }.to raise_error('Cannot deposit a negative amount')
    end
  end
end