require 'rails_helper'

RSpec.describe Group, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

#グループ名、所属メンバーがあれば有効であること
it "is valid with name, user_ids" do
  User.create(
      name: "ほげ太郎",
      email: "rspectest@gmail.com",
      password: "11111111"
    )

  User.create(
    name: "花子",
    email: "rspectest2@gmail.com",
    password: "11111111"
  )

  group = Group.new(
    name: "hoge",
    user_ids: "1,2"
  )

  expect(group).to be_valid
end
#グループ名がなければ無効であること
it "is invalid without name" do
  group = Group.new(name: nil)

  group.valid?
  expect(group.errors[:name]).to include("グループ名は必須です")

end

#所属メンバーがなければ無効であること
it "is invalid without user_ids" do
  group = Group.new(user_ids: nil)

  group.valid?
  expect(group.errors[:user_ids]).to include("所属ユーザーは自分を含め１名以上選択してください")

end

end
