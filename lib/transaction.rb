class Transaction
  attr_reader :amount
  def initialize(date:, amount:)
    @date = date
    @amount = amount
  end

  def to_s
    "#{@date.strftime('%d.%m.%Y')} #{@amount}"
  end
end