class AddStatusToResource < ActiveRecord::Migration[5.1]
  def change
    add_column :resources, :status, :integer
  end
end
