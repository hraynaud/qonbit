class CreateDirectAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :direct_auths do |t|
      t.references :user, foreign_key: true
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
