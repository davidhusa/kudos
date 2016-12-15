require 'rails_helper'

RSpec.describe Kudo, "kudos" do
  context "Its relations work" do
    it "works" do
      user1 = User.create!({email: "bob@internet.biz",
        password: "aaaaaa",
        password_confirmation: "aaaaaa"})
      user2 = User.create!({email: "fred@internet.biz",
        password: "aaaaaa",
        password_confirmation: "aaaaaa"})

      bob = user1.account
      bob.update_attribute(:name, "Bob")

      fred = user2.account.update_attribute(:name, "Fred")
      fred.update_attribute(:name, "Fred")

      Kudo.create(to: bob, from: fred, comment: "Nice moves, keep it up, proud of you")

    end
  end
end