class AddConditionIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :condition_id, :integer
  end
end
