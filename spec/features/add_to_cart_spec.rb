require 'rails_helper'

RSpec.feature "Visitor adds an item to cart", type: :feature, js: true do

  before :each do
    @category = Category.create! name: 'Apparel'

    @category.products.create!(
      name:  Faker::Hipster.sentence(3),
      description: Faker::Hipster.paragraph(4),
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )

  end

  scenario "View the details for one of the products by clicking on it" do
    # ACT
    visit root_path
    find('.btn-primary').click

    #VERIFY
    expect(page).to have_content 'My Cart (1)'

    # DEBUG
    save_screenshot
  end
  
end
