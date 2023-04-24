class Money
  def initialize(value)
    @value = value
  end

  def to_s
    "%0.2f" % @value
  end

  def to_f
    @value.to_f
  end
end
