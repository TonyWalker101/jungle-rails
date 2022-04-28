require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    
    category = Category.new(name: "Cameras")

    category.save

    context "when all fields present it" do
      it "should save successfully" do

        @product = Product.new(name: "Name", price_cents: 100, quantity: 1, category_id: category.id)

        @product.save
        
        expect(@product.id).to be_present
      end
    end
    
    context "when the product name is missing it" do
      it "should not save" do
        
        @product = Product.new(name: nil, price_cents: 100, quantity: 1, category_id: category.id)
        
        @product.save
        
        expect(@product.id).to be_nil
      end
    end

    context "when the product price is missing it" do
      it "should not save" do
        
        @product = Product.new(name: "name", price_cents: nil, quantity: 1, category_id: category.id)
        
        @product.save
        
        expect(@product.id).to be_nil
      end
    end

    context "when the product quantity is missing it" do
      it "should not save" do
        
        @product = Product.new(name: "name", price_cents: 100, quantity: nil, category_id: category.id)
        
        @product.save
        
        expect(@product.id).to be_nil
      end
    end

    context "when the product category is missing it" do
      it "should not save" do
        
        @product = Product.new(name: "name", price_cents: 100, quantity: 1, category_id: nil)
        
        @product.save
        
        expect(@product.id).to be_nil
      end
    end

  end

end
