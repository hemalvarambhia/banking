require_relative '../lib/bank_account'

describe 'Bank Account' do
  describe 'depositing into an account' do
    it 'does not increase the balance on the account with nothing is deposited' do
      account = BankAccount.new(initial_deposit: 50)

      account.deposit(0)

      expect(account.current_balance).to eq(50)
      expected_statement = [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 50 50"
      ].join("\n")
      expect(account.print_statement).to eq(expected_statement)
    end

    it 'increases the balance on the account when a non-zero amount is deposited' do
      account = BankAccount.new(initial_deposit: 0)

      account.deposit(50)

      expect(account.current_balance).to eq(50)
    end

    it 'writes the deposit transaction to the bank statement' do
      account = BankAccount.new(initial_deposit: 0)

      account.deposit(50)

      expected_statement = [
        'Date Amount Balance',
        "#{Date.today.strftime('%d.%m.%Y')} 50 50"
      ].join("\n")
      expect(account.print_statement).to eq(expected_statement)
    end

    it 'does not allow a negative amount to be deposited into the account' do
      account = BankAccount.new(initial_deposit: 0)

      expect { account.deposit(-50) }.to raise_error('Cannot deposit a negative amount')
    end
  end
end