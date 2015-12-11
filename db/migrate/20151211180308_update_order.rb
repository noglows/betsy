class UpdateOrder < ActiveRecord::Migration
  def change
    add_column :orders, :email, :string
    add_column :orders, :mailing_address, :string
    add_column :orders, :name_on_card, :string
    add_column :orders, :card_number, :string
    add_column :orders, :card_exp, :integer
    add_column :orders, :card_cvv, :integer
    add_column :orders, :zip, :integer
  end
end
