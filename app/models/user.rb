class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :account, dependent: :nullify
  after_commit :create_account, on: :create


  def create_account
    Account.create!(user_id: self.id)
  end

end
