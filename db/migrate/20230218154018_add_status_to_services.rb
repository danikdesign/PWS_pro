class AddStatusToServices < ActiveRecord::Migration[7.0]
  def up
    add_column :services, :status, :boolean
  end

  def down
    remove_column :services, :status, :boolean
  end
end
