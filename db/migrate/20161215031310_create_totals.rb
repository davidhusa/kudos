class CreateTotals < ActiveRecord::Migration[5.0]
  def change
    create_table :totals do |t|
      t.references :to, references: :account
      t.references :from, references: :account
      t.integer :kudos, default: 0

      t.timestamps
    end

    add_foreign_key :totals, :accounts, column: :to_id
    add_foreign_key :totals, :accounts, column: :from_id
    add_index :totals, [:to_id, :from_id], :unique => true
  end
end
