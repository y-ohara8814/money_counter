class ChangeDatatypeDateOfUsages < ActiveRecord::Migration[5.2]
  def change
    change_column :usages, :date, :date
  end
end
