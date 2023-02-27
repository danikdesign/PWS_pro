class RemoveNextDateFromServices < ActiveRecord::Migration[7.0]
  def change
    remove_column :services, :next_date, :date
  end
end
