class ChangeOrders < ActiveRecord::Migration
  def change
    change_column :orders, :card_exp, :date
  end
end
