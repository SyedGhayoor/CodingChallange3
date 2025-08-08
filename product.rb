# Represents a product in the catalog
# Immutable value object that stores product details
class Product
    # @return [String] The product code (e.g., 'R01')
    # @return [String] The product name (e.g., 'Red Widget')
    # @return [Float] The product price (e.g., 32.95)
    attr_reader :code, :name, :price
  
    # Initialize a new product
    # @param code [String] The product code
    # @param name [String] The product name
    # @param price [Float] The product price
    def initialize(code:, name:, price:)
      @code = code
      @name = name
      @price = price
    end
  end
  