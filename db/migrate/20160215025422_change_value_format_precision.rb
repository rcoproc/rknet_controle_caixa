class ChangeValueFormatPrecision < ActiveRecord::Migration
  def change
    change_column :account_appointments, :value, :decimal, precision: 12, scale: 2
    change_column :accounts, :initial_balance, :decimal, precision: 12, scale: 2
  end
end
