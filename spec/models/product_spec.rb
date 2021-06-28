require 'rails_helper'
require 'pp'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it 'should save product with all four fields' do
      category = Category.create(name:"Jewellery")
      product = Product.new(
        name: 'Wedding Ring',
        quantity: 5,
        price: 6499.99,
        category_id: category.id
      )
      expect(product).to be_present
    end

    it 'should not save product without name' do
      category = Category.create(name:"Jewellery")
      product = Product.new(
        quantity: 5,
        price: 6499.99,
        category_id: category.id
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.first).to eq("Name can't be blank")
    end

    it 'should not save product without price' do
      category = Category.create(name:"Jewellery")
      product = Product.new(
        name: 'Wedding Ring',
        quantity: 5,
        category_id: category.id
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.first).to eq("Price cents is not a number")
    end

    it 'should not save product without quantity' do
      category = Category.create(name:"Jewellery")
      product = Product.new(
        name: 'Wedding Ring',
        price: 6499.99,
        category_id: category.id
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.first).to eq("Quantity can't be blank")
    end

    it 'should not save product without category' do
      category = Category.create(name:"Jewellery")
      product = Product.new(
        name: 'Wedding Ring',
        quantity: 5,
        price: 6499.99,
      )
      expect(product).not_to be_valid
      expect(product.errors.full_messages.first).to eq("Category can't be blank")
    end
  end
end
