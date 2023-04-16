class BankStatement
  def initialize(bank_account)
    @bank_account = bank_account
  end

  def bank_statement_lines
    @bank_account.transactions.map.with_index do |transaction, number|
      print_transaction(transaction) + " " + "#{@bank_account.running_total_up_to(number)}"
    end
  end

  def print_transaction(transaction)
    "#{transaction.date.strftime('%d.%m.%Y')} #{transaction.amount}"
  end

end
