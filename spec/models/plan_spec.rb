require 'rails_helper'

RSpec.describe Plan, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #グループ単位では、重複した月でのプラン作成を許可しないこと
  it "does not allow dubpicate plan month per group" do
    # group = Group.new

    plan = Plan.create(
      money_amount: "9999",
      year: "2020",
      month: "7",
      group_id: "1",
      choice1: "foo",
      choice2: "baa",
      choice3: "hoge"
    )
  end
end
