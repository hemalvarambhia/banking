class BankStatement
  def initialize(bank_account)
    @bank_account = bank_account
  end

  def print
    column_titles = 'Date Amount Balance'
    if @bank_account.no_transactions?
      column_titles
    else
      [
        column_titles,
        lines.join("\n")
      ].join("\n")
    end
  end

  def lines
    @bank_account.map.with_index do |transaction, number|
      print_transaction(transaction) + " " + "#{@bank_account.running_total_up_to(number)}"
    end
  end

  private

  def print_transaction(transaction)
    "#{transaction.date.strftime('%d.%m.%Y')} #{transaction.amount}"
  end
end
