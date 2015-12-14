require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product_valid) { Product.new(name: "test", price: 20, user_id: 3, inventory_total: 0)}

  describe ".validates" do
    it "must have a name" do
      product = Product.new(price: 30, user_id: 2, inventory_total: 1)
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :name
      expect(product_valid).to be_valid
    end

    it "must have a price" do
      product = Product.new(name:"test",user_id: 2, inventory_total: 1)
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :price
    end

    it "must have a user id" do
      product = Product.new(price: 30, name:"test", inventory_total: 1)
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :user_id
    end

    it "must have a unique name" do
      product_first = Product.new(name: "test", price: 30, user_id: 2, inventory_total: 1)
      product_first.save
      expect(product_valid).to_not be_valid
      expect(product_valid.errors.keys).to include :name
    end

    it "must have a price greater than 0" do
      product = Product.new(price: -2, user_id: 2, name: "test", inventory_total: 1)
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :price
    end

    it "must have an inventory total" do
      product = Product.new(price: 200, user_id: 2, name: "test")
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :inventory_total
    end

    it "must have an non-negative inventory" do
      product = Product.new(price: 200, user_id: 2, name: "test", inventory_total: -4)
      expect(product).to_not be_valid
      expect(product.errors.keys).to include :inventory_total
    end
  end
end
