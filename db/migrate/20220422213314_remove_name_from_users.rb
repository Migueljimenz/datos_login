class RemoveNameFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :second_name, :string
    remove_column :users, :second_last_name, :string
  end
end
