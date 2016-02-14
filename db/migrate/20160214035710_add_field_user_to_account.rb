class AddFieldUserToAccount < ActiveRecord::Migration
  def change
    add_reference :accounts, :user,    index: true, foreign_key: true, default: 1
  end
end
