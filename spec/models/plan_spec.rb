require 'rails_helper'

RSpec.describe Plan, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  #設定金額、対象の年、対象の月、選択肢１、選択肢２、選択肢３,グループIDがあれば有効であること
  it "is valid with a money_amount, year, month, choice1, choice2, choice3" do
    plan = Plan.new(
      money_amount: "10000",
      year: "2020",
      month: "7",
      choice1: "foo",
      choice2: "bar",
      choice3: "hoge",
      group_id: "1"
    )
    expect(plan).to be_valid
  end
  #設定金額がなければ無効な状態であること
  it "is invalid without money_amount" do
    plan = Plan.new(
      money_amount: nil
    )
    plan.valid?
    expect(plan.errors[:money_amount]).to include("can't be blank")
  end

  #対象の年がなければ無効な状態であること
  it "is invalid without year" do
    plan = Plan.new(
      year: nil
    )
    plan.valid?
    expect(plan.errors[:year]).to include("can't be blank")
  end

  #対象の月がなければ無効な状態であること
  it "is invalid without month" do
    plan = Plan.new(
      year: nil
    )
    plan.valid?
    expect(plan.errors[:month]).to include("can't be blank")
  end

  #選択肢１がなれけば無効な状態であること
  it "is invalid without choice1" do
    plan = Plan.new(
      choice1: nil
    )
    plan.valid?
    expect(plan.errors[:choice1]).to include("can't be blank")
  end

  #選択肢２がなければ無効な状態であること
  it "is invalid without choice2" do
    plan = Plan.new(
      choice2: nil
    )
    plan.valid?
    expect(plan.errors[:choice2]).to include("can't be blank")
  end

  #選択肢３がなければ無効な状態であること
  it "is invalid without choice3" do
    plan = Plan.new(
      choice3: nil
    )
    plan.valid?
    expect(plan.errors[:choice3]).to include("can't be blank")
  end

  #グループ単位では、重複した月でのプラン作成を許可しないこと
  it "does not allow dubpicate plan month per group" do
    # group = Group.new

    Plan.create(
      money_amount: "9999",
      year: "2020",
      month: "7",
      group_id: "1",
      choice1: "foo",
      choice2: "baa",
      choice3: "hoge"
    )

    plan = Plan.new(
      money_amount: "9999",
      year: "2020",
      month: "7",
      group_id: "1",
      choice1: "foo",
      choice2: "baa",
      choice3: "hoge"
    )

    plan.valid?
    expect(plan.errors[:month]).to include("この月のプランは作成済みです")
  end
end
