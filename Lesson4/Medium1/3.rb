class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# Changing line 2 to attr_accessor would fix the above code
# but this unnecessarily exposes quanitity so that it
# can now be altered outside of the class definition
# without going through the update_quantity method
# which means it circumvents the checking for a positive number