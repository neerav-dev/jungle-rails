require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      10.times do |n|
        @category.products.create!(
          name:  Faker::Hipster.sentence(3),
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      end
    end
  
    scenario "Cart being updated" do
      visit root_path
      first("article.product").click_button("Add")
      
      expect(page).to have_text "My Cart (1)"
      save_screenshot ("3_cart_being_updated_with_one.png")
    end
end
