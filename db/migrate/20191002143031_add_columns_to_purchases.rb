class AddColumnsToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :refunded, :boolean, default: false
  end
end
