require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:order_valid) { Order.new(status: "test", user_id: 2)}

  describe ".validates" do

    it "must have a status" do
      order = Order.new()
      expect(order).to_not be_valid
      expect(order.errors.keys).to include :status
      #expect(order_valid).to be_valid
    end
  end
end
