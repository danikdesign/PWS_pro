class FixColumnName < ActiveRecord::Migration[7.0]
  def self.up
    rename_column :clients, :putifier_pump, :purifier_pump
  end

  def self.down
  end
end
