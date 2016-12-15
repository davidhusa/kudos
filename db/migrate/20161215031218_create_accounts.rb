class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :photo
      t.text :about
      t.string :default_role
      t.string :status
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
