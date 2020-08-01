class RemoveDateFromUsages < ActiveRecord::Migration[5.2]
  def change
    remove_column :usages, :date, :date
  end
end
