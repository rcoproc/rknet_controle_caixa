class RenameTableAccountsAppointments < ActiveRecord::Migration
  def change
    rename_table :accounts_appointments, :account_appointments
  end
end
