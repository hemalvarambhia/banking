require_relative '../lib/money'
describe 'Money' do
  example 'an amount of money being less than another' do
    expect(Money.new(5.00)).to be < 6.51
  end

  example 'we can add two amounts of money'
end