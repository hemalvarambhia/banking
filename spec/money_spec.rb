require_relative '../lib/money'
describe 'Money' do
  example 'an amount of money being less than another number' do
    expect(Money.new(5.00)).to be < Money.new(10.99)
  end

  example 'an amount of money is not less than another of the same amount' do
    expect(Money.new(12.01)).not_to be < Money.new(12.01)
  end

  example 'we can add two positive amounts of money' do
    total = Money.new(4.50) + Money.new(6.00)

    expect(total.value).to eq(10.50)
  end

  example 'we can add a positive amount of money to a negative one and get a positive total' do
    total = Money.new(6.50) + Money.new(-1.10)

    expect(total.value).to eq(5.40)
  end

  example 'we can add a positive amount of money to a negative one and get a negative total' do
    total = Money.new(10.00) + Money.new(-11.99)

    expect(total.value).to eq(-1.99)
  end

  example 'we can add a positive amount of money to a negative one and compute a zero total' do
    total = Money.new(19.11) + Money.new(-19.11)

    expect(total.value).to eq(0.00)
  end

  example 'we can add two negative amounts of money' do
    total = Money.new(-5.11) + Money.new(-0.02)

    expect(total.value).to eq(-5.13)
  end
end