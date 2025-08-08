# Example script demonstrating the WidgetCart functionality

# Import required classes
require_relative 'product'
require_relative 'basket'
require_relative 'delivery_rule'
require_relative 'offers/bogo_red_widget_offer'

# Create the product catalog with the three widget types
# Maps product codes to Product objects
catalog = {
  'R01' => Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
  'G01' => Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
  'B01' => Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
}

# Set up delivery rules:
# - Orders under $50: $4.95 delivery
# - Orders under $90: $2.95 delivery
# - Orders $90+: Free delivery (default)
delivery_rule = DeliveryRule.new([
  [50, 4.95],
  [90, 2.95]
])

# Set up the promotional offers
# Currently only implementing the "buy one red widget, get the second half price" offer
offers = [BogoRedWidgetOffer.new]

# Create a new basket with our catalog, delivery rules, and offers
basket = Basket.new(product_catalog: catalog, delivery_rule: delivery_rule, offers: offers)

# Add products to the basket: 2 Blue Widgets and 3 Red Widgets
# This should demonstrate the BOGO offer on Red Widgets
%w[B01 B01 R01 R01 R01].each { |code| basket.add(code) }

# Calculate and display the total
# Expected result: $98.27
puts "Total: #{basket.total}"
