# Implementation of the "Buy One Get One Half Price" offer for Red Widgets
# When a customer buys two Red Widgets, the second one is half price
class BogoRedWidgetOffer < Offer
    # Apply the offer to a collection of products
    # @param products [Array<Product>] The products in the basket
    # @return [Float] The total discount amount to apply
    def apply(products)
      # Filter only Red Widgets (product code R01)
      red_widgets = products.select { |p| p.code == 'R01' }
  
      discount = 0
      # Process Red Widgets in pairs
      red_widgets.each_slice(2) do |pair|
        # Only apply discount if we have a complete pair
        if pair.size == 2
          # Apply 50% discount to the second widget in each pair
          discount += pair[1].price / 2.0
        end
      end
  
      # Return the total discount rounded to 2 decimal places
      discount.round(2)
    end
  end
  