class CreateUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :usages do |t|
      t.integer :spending_money
      t.text :purpose
      t.integer :date
      t.integer :plan_id
      t.integer :user_id
      t.timestamps
    end
  end
end
