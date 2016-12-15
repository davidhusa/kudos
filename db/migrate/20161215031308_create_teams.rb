class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.references :leader, references: :account
      t.string :name

      t.timestamps
    end

    add_foreign_key :teams, :accounts, column: :leader_id

    create_table :accounts_teams do |t|
      t.references :account, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
    add_index :accounts_teams, [:account_id, :team_id], :unique => true
  end
end
