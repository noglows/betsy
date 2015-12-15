require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST 'create'" do
    let(:session) do
      session[:user_id] = nil
    end

    it "sets the user id of the session to the appropriate user id" do

    end
  end

  describe "DELETE 'destroy'" do
    it "sets the user id of the session to nil" do

    end

  end
end
