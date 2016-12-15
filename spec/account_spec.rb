require 'rails_helper'

RSpec.describe Account, "accounts" do
  context "Account" do
    it "is created when a user is created" do
      user = User.create!({email: "guy@internet.biz",
        password: "aaaaaa",
        password_confirmation: "aaaaaa"})
      expect(user.admin?).to eq(false)

      expect(user.account).to_not be_nil

      expect(Account.from_user(user)).to eq(user.account)
    end
  end
end