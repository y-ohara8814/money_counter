require 'rails_helper'
require 'pry'

RSpec.describe Group, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

#グループ名、所属メンバーがあれば有効であること
it "is valid with name, user_ids" do
  group = FactoryBot.create(:group, :with_two_users)

  expect(group).to be_valid
end
#グループ名がなければ無効であること
it "is invalid without name" do
  # user1 = FactoryBot.create(:user)
  # user2 = FactoryBot.create(:user)
  # group = FactoryBot.build(:group,name: nil)

  # group = FactoryBot.create(:group, :with_two_users ,name: nil)
  group = FactoryBot.create(:group, traits: [:name_nil, :with_two_users])

  group.valid?
  expect(group.errors[:name]).to include("グループ名は必須です")

end

#所属メンバーがなければ無効であること
it "is invalid without user_ids" do
  user1 = FactoryBot.create(:user)
  user2 = FactoryBot.create(:user)
  group = FactoryBot.build(:group,user_ids: nil)

  group.valid?
  expect(group.errors[:user_ids]).to include("所属ユーザーは自分を含め１名以上選択してください")

end

end
