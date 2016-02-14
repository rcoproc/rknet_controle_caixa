class ChangeDefaultValueColumnUserId < ActiveRecord::Migration
  def change
    change_column_default :accounts, :user_id, nil
  end
end
