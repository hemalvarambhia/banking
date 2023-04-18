require 'ostruct'
class BankStatement
  def initialize(bank_account)
    @bank_account = bank_account
  end

  def print
    column_titles = ['Date Amount Balance']
    (column_titles + lines).join("\n")
  end

  def lines
    @bank_account.map.with_index do |transaction, number|
      line = OpenStruct.new(transaction: transaction, balance: balance_as_of(number))
      "#{print_transaction(line.transaction)} #{line.balance}"
    end
  end

  private

  def balance_as_of(number)
    @bank_account.running_total_up_to(number)
  end

  def print_transaction(transaction)
    "#{transaction.date.strftime('%d.%m.%Y')} #{transaction.amount}"
  end
end
