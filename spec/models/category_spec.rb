require 'rails_helper'

RSpec.describe Category, type: :model do

  describe ".validates" do
    it "must have a name" do
      category = Category.new(name: nil)
      expect(post).to_not be_valid
      expect(post.errors.keys).to include :name
    end

  end
end
