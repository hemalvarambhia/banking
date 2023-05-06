require_relative '../lib/money'
describe 'Money' do
  example 'an amount of money being less than another' do
    expect(Money.new(5.00)).to be < 6.51
  end

  example 'we can add two positive amounts of money'

  example 'we can add a positive amount of money to a negative one and get a positive total'

  example 'we can add a positive amount of money to a negative one and get a negative total'

  example 'we can add a positive amount of money to a negative one and compute a zero total'

  example 'we can add two negative amounts of money'
end