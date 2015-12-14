require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:user) do
    User.create(first_name: "Someone",
                last_name: "Else",
                email: "7@7.co",
                password: "pass",
                password_confirmation: "pass")
  end

  describe "POST 'create'" do
    let(:order_item_params) do
      {
        order_item: {
          quantity: 12,
        },
        product_id: 6,
      }
    end

    before :suite do
      cookies.signed[:order] = nil
    end

    it "creates a new order instance when one does not already exist" do
      all_orders = Order.all.to_a
      post :create, order_item_params
      expect(all_orders).not_to include(Order.all.last)
    end

    before :suite do
      ord = Order.create(status:"pending")
      cookies.signed[:order] = ord.id
    end

    it "does not create a new order instance when one already exists" do
      last_order = Order.last
      post :create, order_item_params
      expect(Order.last).to_not eq last_order
    end

    it "redirects to the cart path when successful" do
      post :create, order_item_params
      expect(subject).to redirect_to cart_path
    end

  end

  describe "GET 'cart'" do
    it "renders the cart view" do
      get :cart
      expect(subject).to render_template :cart, { :id => 1 }
    end
  end

  describe "PATCH 'update'" do

    let(:params) do
      {
        order_item: {
          quantity: 12,
          order_id: 1,
          product_id: 6
        },
        product_id: 5
      }
      end

      before :each do
        session[:user_id] = user.id
      end

      it "updates the order item with good params" do
        before_update = order_item.attributes
        patch :update, params, id: order_item.id
        order_item.reload
        expect(order_item.attributes).to_not eq before_update
      end
  end

  describe "DELETE 'destroy'" do
    let(:params) do
          {
            id: order_item.id
          }
    end

    it "deletes an order_item" do
      expect(OrderItem.all).to include(order_item)
      delete :destroy, params
      expect(OrderItem.all).to_not include(order_item)
    end
  end

end
