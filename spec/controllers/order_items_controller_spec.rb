require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
let(:order_id)do
  OrderItem.create(quantity: 12, order_id: 1, product_id: 6)
end
  describe "GET 'new'" do
    it "renders the new view" do
      get :new
      expect(subject).to render_template :new, { :id => 1 }
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
