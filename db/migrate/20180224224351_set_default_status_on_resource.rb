class SetDefaultStatusOnResource < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:resources, :status, 0)
  end
end
