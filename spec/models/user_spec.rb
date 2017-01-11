require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe "Userの名前が代入" do
    it "中尾と表示" do
     user = FactoryGirl.(:user).find_by(name: "ryo")
     expect(user.name).to eq '中'
   end
  end
end
