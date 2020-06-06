class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.integer :money_amount
      t.integer :year
      t.integer :month
      t.integer :group_id

      t.timestamps
    end
  end
end
