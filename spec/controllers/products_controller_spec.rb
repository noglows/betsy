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
    let(:user) do
      User.create(first_name: "Someone",
                  last_name: "Else",
                  email: "7@7.co",
                  password: "pass",
                  password_confirmation: "pass")
    end

    before :each do
      session[:user_id] = user.id
    end

    it "renders the new view" do
      get :new, id: user_id
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

  describe "POST 'review'" do
    let(:params) do
      {
        review:{
          rating: "3",
          review_text: "An average rating",
        }
      }
    end

    it "creates a new review of a product" do
      post :review, params.merge(product_id: 1)
      last_review = Review.last
      expect(last_review.review_text).to eq "An average rating"
    end
  end

  describe "POST 'create'" do
    let(:user) do
      User.create(first_name: "Someone",
                  last_name: "Else",
                  email: "7@7.co",
                  password: "pass",
                  password_confirmation: "pass")
    end

    let(:params) do
      {
        product:{
          name: "For Sea Was He",
          description: "A gregarious, lovable sailor",
          price: 2500,
          retired: false,
          inventory_total: 20,
          image_url: "http://www.polyvore.com/cgi/img-thing?.out=jpg&size=l&tid=21795680",
          user_id: 4
        },
        categories: []
      }
    end

    let(:bad_params) do
      {
        product:{
          name: nil,
          price: nil
        },
        categories: []
      }
    end

    before :each do
      session[:user_id] = user.id
    end

    it "creates a product with good params" do
      last_product = Product.last
      post :create, params
      expect(Product.last).to_not eq last_product
    end

    it "does not create a product when bad params are used" do
      last_product = Product.last
      post :create, bad_params
      expect(Product.last).to eq last_product
    end

    it "redirects to products index page when good params are passed" do
      post :create, params.merge(id: 1)
      # Success case to index page
      expect(subject).to redirect_to user_path(user.id)
      # Error case to
    end

    it "renders the edit template when bad params are passed" do
      post :create, bad_params
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    let(:user) do
      User.create(first_name: "Someone",
                  last_name: "Else",
                  email: "7@7.co",
                  password: "pass",
                  password_confirmation: "pass")
    end

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
        id: product.id,
        categories: []
      }
    end

    let(:bad_params) do
      {
        product:{
          name: nil,
          price: nil
        },
        id: product.id,
        categories: []
      }
    end

    before :each do
      session[:user_id] = user.id
    end

    it "updates the product with good params" do
      before_update = product.attributes
      patch :update, params
      product.reload
      expect(product.attributes).to_not eq before_update
    end

    it "does not update the product with bad params" do
      before_update = product.attributes
      patch :update, bad_params, id: user.id, id: product.id
      product.reload
      expect(product.attributes).to eq before_update
    end

    it "redirects to the user page after a successful update" do
      patch :update, id: product.id
      # Success case to index page
      expect(subject).to redirect_to user_path(user.id)
    end

    it "renders the template to update a product with bad params" do
      # Error case to
      patch :update, bad_params, id: product.id
      expect(subject).to render_template :edit
    end
  end

  describe "POST 'retire'" do
    let(:user) do
      User.create(first_name: "Someone",
                  last_name: "Else",
                  email: "7@7.co",
                  password: "pass",
                  password_confirmation: "pass")
    end

    before :each do
      session[:user_id] = user.id
    end

    it "sets the status of a product to retired" do
      post :retire, product_id: product.id, user_id: user.id
      product.reload
      expect(product.retired).to eq true
    end

    it "redirects to the user path" do
      post :retire, product_id: product.id, user_id: user.id
      expect(subject).to redirect_to user_path(user.id)
    end
  end

end
