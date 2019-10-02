class AddRefundFlagToTaxes < ActiveRecord::Migration[5.2]
  def change
    add_column :taxes, :refunded, :boolean, default: false
  end
end
