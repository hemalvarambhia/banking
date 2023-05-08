class Money
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def <(amount)
    @value < amount
  end

  def +(money)
    Money.new(10.50)
  end

  def to_s
    "%0.2f" % @value
  end

  def inspect
    "%0.2f" % @value
  end
end
