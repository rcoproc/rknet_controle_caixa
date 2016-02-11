class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name, limited: 50
      t.string :bank, limited: 50
      t.string :bank_office, limited: 30
      t.decimal :initial_balance, precision: 12, decimal: 2
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
