require_relative '../lib/money'
describe 'Money' do
  example 'an amount of money being less than another' do
    expect(Money.new(5.00)).to be < Money.new(6.51)
  end
end