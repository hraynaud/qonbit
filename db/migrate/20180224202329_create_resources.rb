class CreateResources < ActiveRecord::Migration[5.1]
  def change
    create_table :resources do |t|
      t.references :domain, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :specialist_id

      t.timestamps
    end
  end
end
