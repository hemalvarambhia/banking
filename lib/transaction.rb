class Transaction
  attr_reader :date
  def initialize(date:, value:)
    @date = date
    @amount = value
  end

  def amount
    @amount.to_f
  end

  def to_s
    "#{@date.strftime('%d.%m.%Y')} #{@amount}"
  end
end