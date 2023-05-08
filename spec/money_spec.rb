require_relative '../lib/money'
describe 'Money' do
  example 'an amount of money being less than another number' do
    expect(Money.new(5.00)).to be < 6.51
  end

  example 'we can add two positive amounts of money' do
    total = Money.new(4.50) + Money.new(6.00)

    expect(total.value).to eq(10.50)
  end

  example 'we can add a positive amount of money to a negative one and get a positive total' do
    total = Money.new(6.50) + Money.new(-1.10)

    expect(total.value).to eq(5.40)
  end

  example 'we can add a positive amount of money to a negative one and get a negative total'

  example 'we can add a positive amount of money to a negative one and compute a zero total'

  example 'we can add two negative amounts of money'
end