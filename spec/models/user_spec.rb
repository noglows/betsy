require 'rails_helper'

RSpec.describe User, type: :model do

  let(:password) { BCrypt::Password.create("password") }

  let(:user_valid) { User.new(email: "test@test.com", password: password) }

  describe ".validates" do
    it "must have a email" do
      user = User.new(password: password)
      expect(user).to_not be_valid
      expect(user.errors.keys).to include :email
      expect(user_valid).to be_valid
    end

    it "must have a unique email" do
      user_first = User.new(email:"test@test.com", password: password)
      user_first.save
      expect(user_valid).to_not be_valid
      expect(user_valid.errors.keys).to include :email
    end

    it "must have a valid email format" do
      user = User.new(password: password, email: "test")
      expect(user).to_not be_valid
      expect(user.errors.keys).to include :email
    end
  end
end
