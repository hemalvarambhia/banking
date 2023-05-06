class Transaction
  attr_reader :amount, :date
  def initialize(date:, amount: nil, value:)
    @date = date
    @amount = value
  end

  def amount
    @amount.value.to_f
  end

  def to_s
    "#{@date.strftime('%d.%m.%Y')} #{@amount}"
  end
end