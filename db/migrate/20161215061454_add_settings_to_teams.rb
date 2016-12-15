class AddSettingsToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :sprint, :integer, default: 0
    add_column :teams, :start_date, :date
    add_column :teams, :sprint_days, :integer, default: 7
  end
end
