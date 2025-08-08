# Handles delivery charge calculations based on order total thresholds
# For example: orders under $50 cost $4.95, orders under $90 cost $2.95, orders $90+ are free
class DeliveryRule
    # Initialize with delivery charge thresholds
    # @param thresholds [Array<Array>] Array of [amount, charge] pairs
    #   e.g. [[50, 4.95], [90, 2.95]] means:
    #   - Orders under $50 cost $4.95 delivery
    #   - Orders under $90 cost $2.95 delivery
    #   - Orders $90+ have free delivery (default return value of 0)
    def initialize(thresholds)
      # Sort thresholds by amount to ensure correct evaluation order
      @thresholds = thresholds.sort_by { |amount, _| amount }
    end
  
    # Calculate the delivery charge for a given order total
    # @param total [Float] The order total after discounts
    # @return [Float] The delivery charge to apply
    def delivery_charge(total)
      # Check each threshold in ascending order
      @thresholds.each do |amount, charge|
        return charge if total < amount
      end
      # Default to free delivery (0) if no thresholds are matched
      0
    end
  end
  