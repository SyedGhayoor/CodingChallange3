# Base class for all promotional offers
# Follows the Strategy pattern to allow for different offer implementations
class Offer
    # Apply the offer to a collection of products
    # @param products [Array<Product>] The products in the basket
    # @return [Float] The total discount amount to apply
    # @raise [NotImplementedError] This is an abstract method that must be implemented by subclasses
    def apply(products)
      raise NotImplementedError
    end
  end
  