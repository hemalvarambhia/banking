require 'ostruct'
class BankStatement
  StatementLine = Data.define(:transaction, :balance)
  def initialize(bank_account)
    @bank_account = bank_account
  end

  def print
    column_titles = ['Date Amount Balance']
    (column_titles + lines).join("\n")
  end

  def lines
    @bank_account.map.with_index do |transaction, number|
      line = StatementLine.new(transaction: transaction, balance: balance_as_of(number))
      "#{print_transaction(line.transaction, line)}"
    end
  end

  private

  def balance_as_of(number)
    @bank_account.running_total_up_to(number)
  end

  def print_transaction(transaction, line)
    "#{line.transaction.date.strftime('%d.%m.%Y')} #{line.transaction.amount} #{line.balance}"
  end
end
