class RemoveDocumentFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :document, :integer
  end
end
