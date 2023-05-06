class Transaction
  attr_reader :amount, :date
  def initialize(date:, amount:, value: nil)
    @date = date
    @amount = Money.new(amount)
  end

  def amount
    @amount.value.to_f
  end

  def to_s
    "#{@date.strftime('%d.%m.%Y')} #{@amount}"
  end
end