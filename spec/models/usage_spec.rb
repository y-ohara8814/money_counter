require 'rails_helper'

RSpec.describe Usage, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  #使った日、使った金額、用途、プランIDがあれば有効であること
  it "is valid with date, spending_money, purpose, plan_id" do
  usage = FactoryBot.build(:usage, :with_user, :with_choice1)
  expect(usage).to be_valid
  end
  #使った日がなければ無効であること
  it "is invalid without date" do
    usage = FactoryBot.build(:usage, date: nil)
    usage.valid?
    expect(usage.errors[:date]).to include("can't be blank")
  end
  #使った金額がなければ無効であること
  it "is invalid without spending_money" do
    usage = FactoryBot.build(:usage, spending_money: nil)
    usage.valid?
    expect(usage.errors[:spending_money]).to include("can't be blank")
  end

  #用途が選択されていなければ無効であること
  it "is invalid without purpose" do
    usage = FactoryBot.build(:usage, purpose: nil)
    usage.valid?
    expect(usage.errors[:purpose]).to include("can't be blank")
  end

  #プランIDがなければ無効であること
  it "is invalid without plan_id" do
    usage = FactoryBot.build(:usage, plan_id: nil)
    usage.valid?
    expect(usage.errors[:plan_id]).to include("can't be blank")
  end

end
