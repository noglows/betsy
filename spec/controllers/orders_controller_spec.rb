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
    Order.create(status:"pending", user_id: 4)
  end

  describe "GET 'index'" do

  end

  describe "GET 'new'" do
    it "renders the new view" do
      get :new, id: user.id
      expect(subject).to render_template :new
    end
  end

  describe "GET 'show'" do

  end

  describe "PATCH 'update'" do

  end

  describe "PATCH 'ship'" do


  end

end
