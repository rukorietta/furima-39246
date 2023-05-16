class AddDeliveryDayIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :delivery_day_id, :integer
  end
end
