class Total < ApplicationRecord
  belongs_to :to, class_name: :Account, foreign_key: :to_id
  belongs_to :from, class_name: :Account, foreign_key: :from_id
  belongs_to :team
  validates :to_id, uniqueness: {scope: :from_id}
end
