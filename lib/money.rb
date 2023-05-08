class Money
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def <(amount)
    @value < amount
  end

  def +(money)
    Money.new(@value + money.value)
  end

  def to_f
    @value.to_f
  end

  def to_s
    "%0.2f" % @value
  end

  def inspect
    "%0.2f" % @value
  end
end
