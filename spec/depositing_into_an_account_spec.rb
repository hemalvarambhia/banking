require 'date'
require 'ostruct'
require_relative '../lib/bank_account'

describe 'Bank Account' do
  describe 'depositing into an account' do
    it 'does not increase the balance on the account with nothing is deposited' do
      account = BankAccount.new(initial_deposit: 50)

      account.deposit(0)

      expect(account.current_balance).to eq(50)
    end

    it 'increases the balance on the account when a non-zero amount is deposited'

    it 'does not allow a negative amount to be deposited into the account'
  end
end