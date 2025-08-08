# Tests for the Basket class functionality
# Verifies that the basket correctly calculates totals with various product combinations

require_relative '../product'
require_relative '../basket'
require_relative '../delivery_rule'
require_relative '../offers/bogo_red_widget_offer'

RSpec.describe Basket do
  # Set up the product catalog with the three widget types
  let(:catalog) do
    {
      'R01' => Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
      'G01' => Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
      'B01' => Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
    }
  end

  # Set up delivery rules:
  # - Orders under $50: $4.95 delivery
  # - Orders under $90: $2.95 delivery
  # - Orders $90+: Free delivery
  let(:delivery_rule) { DeliveryRule.new([[50, 4.95], [90, 2.95]]) }
  
  # Set up the promotional offers
  # Currently only implementing the "buy one red widget, get the second half price" offer
  let(:offers) { [BogoRedWidgetOffer.new] }

  # Helper method to create a basket with specified product codes
  # @param codes [Array<String>] Product codes to add to the basket
  # @return [Basket] A basket with the specified products added
  def basket_for(*codes)
    basket = Basket.new(product_catalog: catalog, delivery_rule: delivery_rule, offers: offers)
    codes.each { |code| basket.add(code) }
    basket
  end

  # Test case 1: Blue Widget + Green Widget
  # Total: $32.90 (products) + $4.95 (delivery) = $37.85
  # No offers apply, and total is under $50 so delivery is $4.95
  it 'calculates total for B01, G01' do
    expect(basket_for('B01', 'G01').total).to eq('$37.85')
  end

  # Test case 2: Two Red Widgets
  # Total: $65.90 (products) - $16.48 (50% off second red widget) + $4.95 (delivery) = $54.37
  # BOGO offer applies, and total after discount is under $50 so delivery is $4.95
  it 'calculates total for R01, R01' do
    expect(basket_for('R01', 'R01').total).to eq('$54.37')
  end

  # Test case 3: Red Widget + Green Widget
  # Total: $57.90 (products) + $2.95 (delivery) = $60.85
  # No offers apply, and total is between $50 and $90 so delivery is $2.95
  it 'calculates total for R01, G01' do
    expect(basket_for('R01', 'G01').total).to eq('$60.85')
  end

  # Test case 4: Two Blue Widgets + Three Red Widgets
  # Total: $15.90 (blue widgets) + $98.85 (red widgets) - $16.48 (50% off second red widget) = $98.27
  # BOGO offer applies once (to first pair of red widgets), and total after discount is over $90 so delivery is free
  it 'calculates total for B01, B01, R01, R01, R01' do
    expect(basket_for('B01', 'B01', 'R01', 'R01', 'R01').total).to eq('$98.27')
  end
end
