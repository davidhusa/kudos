class CreateKudos < ActiveRecord::Migration[5.0]
  def change
    create_table :kudos do |t|
      t.references :to, references: :account
      t.references :from, references: :account
      t.string :comment

      t.timestamps
    end
    
    add_foreign_key :kudos, :accounts, column: :to_id
    add_foreign_key :kudos, :accounts, column: :from_id
  end
end
