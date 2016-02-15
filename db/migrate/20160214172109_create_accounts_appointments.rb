class CreateAccountsAppointments < ActiveRecord::Migration
  def change
    create_table :accounts_appointments do |t|
      t.date   :date
      t.string :description, limit:50
      t.string :document,    limit:20
      t.string :type,        limit:1
      t.decimal :value

      t.timestamps null: false
    end

    add_reference :accounts_appointments, :account, index: true , foreign_key: true
  end
end
