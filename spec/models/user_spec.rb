require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #名前、メールアドレス、パスワードがあれば有効な状態であること
  it "is valid with a name, mailaddress, password" do
    user = User.new(
      name: "ほげ太郎",
      email: "rspectest@gmail.com",
      password: "11111111"
    )
    expect(user).to be_valid
  end
  #名前がなければ無効な状態であること
  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  #メールアドレスがなければ無効な状態であること
  it "is invalid without a mailaddress" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  #パスワードがなければ無効な状態であること
  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end
end
