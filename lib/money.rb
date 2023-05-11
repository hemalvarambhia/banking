class Money
  attr_reader :value
  def initialize(value)
    @value = value.round(2)
  end

  def <(amount)
    @value < amount.value
  end

  def >(amount)
    @value > amount.value
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
