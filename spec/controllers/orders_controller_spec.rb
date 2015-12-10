require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order) do
    Order.create(status:"pending", user_id: 4)
  end
end
