class AddTeamIdToKudosAndTotals < ActiveRecord::Migration[5.0]
  def change
    add_reference :kudos, :team, index: true
    add_reference :totals , :team, index: true
  end
end
