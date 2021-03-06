require 'rails_helper'

describe "the add a product process" do
  it "adds a new product" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :admin => true )
    user.save
    visit '/'
    fill_in 'user_email', :with => 'test@example.com'
    fill_in 'user_password', :with => 'f4k3p455w0rd'
    click_on 'commit'
    visit products_path
    click_link 'Add a new product'
    fill_in 'Name', :with => 'Juno 106'
    fill_in 'Cost', :with => '1,100'
    fill_in 'Country of origin', :with => 'Japan'
    click_on 'Create Product'
    expect(page).to have_content 'Product added!'
    expect(page).to have_content 'Juno 106'
  end

  it "gives an error when no name is entered" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :admin => true )
    user.save
    visit '/'
    fill_in 'user_email', :with => 'test@example.com'
    fill_in 'user_password', :with => 'f4k3p455w0rd'
    click_on 'commit'
    visit new_product_path
    click_on 'Create Product'
    expect(page).to have_content "Name can't be blank"
  end
end