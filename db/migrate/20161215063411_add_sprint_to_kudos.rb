class AddSprintToKudos < ActiveRecord::Migration[5.0]
  def change
    add_column :kudos, :sprint, :integer
  end
end
