class Money
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def <(amount)
    if amount.is_a?(Money)
      @value < amount.value
    else
      @value < amount
    end
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
