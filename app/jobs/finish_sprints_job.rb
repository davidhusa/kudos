# This must be run daily in the early morning

class FinishSprintsJob < ApplicationJob 
  queue_as :default

  def perform(*args)
     Team.all.each do |team|
       if team.sprint_end_day?
         team.update_attribute(sprint: team.sprint+=1)
     end
  end
end
