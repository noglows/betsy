require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  let(:user) do
    User.create(first_name: "Someone",
                last_name: "Else",
                email: "7@7.co",
                password: "pass",
                password_confirmation: "pass")
  end

  let(:order) do
    Order.create(status: "pending",
                 email: "caprina.keller@test.com",
                 mailing_address: "3158 Union Street,
                 Reisterstown, MD",
                 name_on_card: "Caprina Keller",
                 last_four: "1911",
                 card_exp: Date.today,
                 zip: "22136"
    )
  end

  describe "GET 'index'" do
    it "renders the index view" do
      get :index, user_id: user.id
      expect(subject).to render_template :index
    end

  end

  describe "GET 'show'" do
    it "renders the show page" do
      get :show, id: order.id, user_id: user.id
      expect(subject).to render_template :show
    end
  end

  describe "GET 'checkout'" do
    before :suite do
      cookies.signed[:order] = order.id
      # cookies.signed[:stocked] = order.length
      session[:order] = nil
    end

    it "renders checkout view if cart is not empty" do
      order_item = OrderItem.create(quantity: 4,
                         product_id: 5,
                         shipped: false,
                         order_id: order.id)
      product = Product.create(name: "Fuzzy Wah-Wah pedal",
                         description: "Making some glorious vintage guitar sounds",
                         price: 4000,
                         inventory_total: 50,
                         retired: false,
                         image_url: "http://i.ebayimg.com/images/i/251806872987-0-1/s-l1000.jpg",
                         user_id: user.id)
      get :checkout
      expect(subject).to render_template :checkout
    end
  end

  describe "PATCH 'update'" do

  end

  describe "PATCH 'ship'" do


  end

end
