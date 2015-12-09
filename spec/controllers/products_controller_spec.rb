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

    it "shows the proper user_id" do
      @user_id = 1
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

  describe "GET 'edit'" do
    it "renders the edit view" do
      get :edit, id: product.id
      expect(subject).to render_template :edit
    end
  end


  describe "POST 'create'" do
    let(:params) do
      {
        product:{
          name: "For Sea Was He",
          description: "A gregarious, lovable sailor",
          price: 2500,
          retired: false,
          image_url: "http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=21795680",
          user_id: 4
        }
      }
    end

    let(:bad_params) do
      {
        product:{
          name: nil,
          price: nil
        }
      }
    end

    it "creates an product" do
      last_product = Album.last
      post :create, params
      expect(Product.last).to_not eq last_product
    end

    it "does not create a product when bad params are used" do
      last_product = Product.last
      post :create, bad_params
      expect(Product.last).to eq last_product
    end

    it "redirects to products index page" do
      post :create, params
      # Success case to index page
      expect(subject).to redirect_to products_path
      # Error case to
      post :create, bad_params
      expect(subject).to render_template :new
    end
  end

  describe "PATCH 'update'" do
    let(:params) do
      {
        product:{
          name: "For Sea Was He",
          description: "A gregarious, lovable sailor",
          price: 2500,
          retired: false,
          image_url: "http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=21795680",
          user_id: 4
        },
        id: product.id
      }
    end

    let(:bad_params) do
      {
        product:{
          name: nil,
          price: nil
        },
        id: product.id
      }
    end

    it "updates the product with good params" do
      before_update = product.attributes
      patch :update, params
      product.reload
      expect(product.attributes).to_not eq before_update
    end

    it "does not update the album with bad params" do
      before_update = product.attributes
      patch :update, bad_params
      product.reload
      expect(product.attributes).to eq before_update
    end

    it "redirects to the product's show page after a successful update" do
      patch :update, params
      # Success case to index page
      expect(subject).to redirect_to product_path
      # Error case to
      patch :update, bad_params
      expect(subject).to render_template :edit
    end
  end

  describe "DELETE 'destroy'" do
    let(:params) do
      {
        id: product.id
      }
    end

    it "deletes an album" do
      expect(Product.all).to include(product)
      delete :destroy, params
      expect(Product.all).to_not include(product)
    end

    it "renders the all products view" do
      get :index
      expect(subject).to render_template :index
    end
  end

end
