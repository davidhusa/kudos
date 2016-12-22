require 'rake'

task :finish_sprint => :environment do
  Team.all.each do |team|
    if team.sprint_end_day?
      team.update_attribute(:sprint, team.sprint+=1)
    end
  end
end