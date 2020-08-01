class AddDateToUsages < ActiveRecord::Migration[5.2]
  def change
    add_column :usages, :date, :date
  end
end
