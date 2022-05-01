class AddDocumentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :document, :integer
  end
end
