class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :account
  after_commit :create_account, on: :create


  def create_account
    self.email.match /\A(.*)@/
    Account.create!(user_id: self.id, name: $1)
  end

end
