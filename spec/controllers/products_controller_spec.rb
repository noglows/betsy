require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) do
    Product.create(name: "Fuzzy Horsey", description: "Adorable stuffed horse given to me as a random act of kindness", price: 1000, inventory_total: 55, retired: false, image_url: "http://ecx.images-amazon.com/images/I/51U15zrxjiL._SY300_QL70_.jpg", user_id: 2)
  end

  describe "GET 'index'" do
    it "is successful" do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe "GET 'new'" do
    it "renders the new view" do
      get :new, id: product.id
      expect(subject).to render_template :new
    end
  end

  describe "GET 'show'" do
    it "renders the show view" do
      get :show, id: product.id
      expect(subject).to render_template :show
    end
  end

end
