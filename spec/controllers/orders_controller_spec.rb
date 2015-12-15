require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  describe "GET 'index'" do
    it "renders the index view" do
      get :index, user_id: 4
      expect(subject).to render_template :index
    end
  end

  # describe "GET 'new'" do
  #   it "renders the new view" do
  #     get :new
  #     expect(subject).to render_template :new
  #   end
  # end
  #
  # describe "GET 'show'" do
  #   it "renders the show page" do
  #
  #   end
  #
  # end
  #
  # describe "PATCH 'update'" do
  #
  # end
  #
  # describe "PATCH 'ship'" do
  #
  #
  # end

  # let(:order_params) do
  #   {
  #     order: {
  #       email: "name@test.com",
  #       mailing_address: "1234 Awesome Pl",
  #       zip: "12345",
  #       name_on_card: "Name McNamerson",
  #       card_exp: "1212",
  #     },
  #     last_four: "1234",
  #     user_id: new_order.user_id
  #   }
  # end
  #

end
