class Transaction
  attr_reader :date
  def initialize(date:, value:)
    @date = date
    @amount = value
  end

  def amount
    @amount.to_f
  end
end