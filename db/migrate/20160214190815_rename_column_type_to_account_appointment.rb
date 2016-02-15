class RenameColumnTypeToAccountAppointment < ActiveRecord::Migration
  def change
    rename_column :accounts_appointments, :type, :deb_cre
  end
end
