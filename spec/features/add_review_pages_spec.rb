require 'rails_helper'

describe "the add a review process" do
  it "adds a review" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :admin => true )
    user.save
    visit '/'
    fill_in 'user_email', :with => 'test@example.com'
    fill_in 'user_password', :with => 'f4k3p455w0rd'
    click_on 'commit'
    product = Product.new({name: 'Juno 106', cost: '1,200', country_of_origin: 'Japan'})
    product.save
    visit product_path(product)
    click_link 'Add a review'
    fill_in 'Author', :with => 'Andy'
    fill_in 'Content body', :with => "If you are looking for classic 80's synth tones, look no further! Works like a charm! Will definitely buy again!"
    fill_in 'Rating', :with => '5'
    click_on 'Create Review'
    expect(page).to have_content 'Review added!'
    expect(page).to have_content 'Andy'
  end

  it "gives an error when no author is entered" do
    user = User.create!(:email => 'test@example.com', :password => 'f4k3p455w0rd', :admin => true )
    user.save
    visit '/'
    fill_in 'user_email', :with => 'test@example.com'
    fill_in 'user_password', :with => 'f4k3p455w0rd'
    click_on 'commit'
    product = Product.new({name: 'Juno 106', cost: '1,200', country_of_origin: 'Japan'})
    product.save
    visit new_product_review_path(product.id)
    click_on 'Create Review'
    expect(page).to have_content "Author can't be blank"
  end
end