class AddUsernameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username
    change_column :users, :email, :string, null: false
    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name, :string, null: false
    change_column :users, :first_name_kana, :string, null: false
    change_column :users, :last_name_kana, :string, null: false
    change_column :users, :birth_date, :date, null: false
  end
end
