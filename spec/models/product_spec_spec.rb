require 'rails_helper'

RSpec.describe Product, type: :model do
  
  describe "Validations" do

    it "no errors exist when all product fields are provided" do
      @category = Category.create(name: "Food")
      @product = Product.create(name: "Burger", price: 200, quantity: 1, category: @category)
      expect(@product.errors.full_messages).to eq([])
    end

    it "provides an error message when name is nil" do
      @category = Category.create(name: "Food")
      @product = Product.create(name: nil, price: 200, quantity: 1, category: @category)
      expect(@product.errors.full_messages[0]).to_not be_nil
    end

    it "provides an error message when price is nil" do
      @category = Category.create(name: "Food")
      @product = Product.create(name: "Burger", price: nil, quantity: 1, category: @category)
      expect(@product.errors.full_messages[0]).to_not be_nil
    end

    it "provides an error message when quantity is nil" do
      @category = Category.create(name: "Food")
      @product = Product.create(name: "Burger", price: 200, quantity: nil, category: @category)
      expect(@product.errors.full_messages[0]).to_not be_nil
    end

    it "provides an error message when category is nil" do
      @product = Product.create(name: "Burger", price: 200, quantity: 1, category: nil)
      expect(@product.errors.full_messages.length).to eq(1)
    end
    
  end
  
end
