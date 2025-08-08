require_relative 'product'
require_relative 'delivery_rule'
require_relative 'offer'

# Main class that implements the shopping basket functionality
# Handles adding products and calculating the total cost with discounts and delivery
class Basket
  # Initialize a new basket
  # @param product_catalog [Hash] A hash mapping product codes to Product objects
  # @param delivery_rule [DeliveryRule] The delivery charge calculation rule
  # @param offers [Array<Offer>] Optional array of promotional offers to apply
  def initialize(product_catalog:, delivery_rule:, offers: [])
    @catalog = product_catalog
    @delivery_rule = delivery_rule
    @offers = offers
    @items = []
  end

  # Add a product to the basket by its code
  # @param product_code [String] The code of the product to add
  # @raise [RuntimeError] If the product code is not found in the catalog
  # @return [Product] The product that was added
  def add(product_code)
    product = @catalog[product_code]
    raise "Product not found: #{product_code}" unless product

    @items << product
  end

  # Calculate the total cost of the basket
  # This includes:
  # 1. The sum of all product prices
  # 2. Any discounts from applicable offers
  # 3. Delivery charges based on the discounted total
  # @return [String] The formatted total price with $ symbol and 2 decimal places
  def total
    # Calculate the sum of all product prices
    subtotal = @items.sum(&:price)
    
    # Apply all offers and sum up the discounts
    offer_discount = @offers.sum { |offer| offer.apply(@items) }
    
    # Calculate the total after discounts
    discounted_total = subtotal - offer_discount
    
    # Calculate delivery charge based on the discounted total
    delivery = @delivery_rule.delivery_charge(discounted_total)
    
    # Calculate the final total (discounted total + delivery)
    final_total = (discounted_total + delivery).round(2)
    
    # Format the total as a currency string
    format('$%.2f', final_total)
  end
end
