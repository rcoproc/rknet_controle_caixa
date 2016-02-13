class AddFieldNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, limit: 50, null: false, default: '' end
end
