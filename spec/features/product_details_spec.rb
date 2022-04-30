require 'rails_helper'

# RSpec.feature "ProductDetails", type: :feature do
#   pending "add some scenarios (or delete) #{__FILE__}"
# end

RSpec.feature "ProductDetails", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  "Blue Shirt",
      description: "This is a blue collard shirt",
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99)
  end

  scenario "they click on a Product and see the Product details" do
    # ACT
    visit root_path
    
    # VERIFY
    expect(page).to have_css 'article.product'
    
    # ACT
    click_on 'Details »'
    
    # VERIFY
    expect(page).to have_css("article.product-detail")
    
    # DEBUG
    save_screenshot
  end

end
