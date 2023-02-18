class AddStatusToInstallations < ActiveRecord::Migration[7.0]
  def up
    add_column :installations, :status, :boolean
  end

  def down
    remove_column :installations, :status, :boolean
  end
end
