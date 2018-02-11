class AddProviderToOauth < ActiveRecord::Migration[5.1]
  def change
    add_column :oauths, :provider, :string
  end
end
