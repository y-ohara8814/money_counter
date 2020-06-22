class AddChoicesToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :choice1, :text
    add_column :plans, :choice2, :text
    add_column :plans, :choice3, :text
  end
end
