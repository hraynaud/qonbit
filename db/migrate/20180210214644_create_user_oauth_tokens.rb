class CreateUserOauthTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :user_oauth_tokens do |t|
      t.string :provider
      t.string :uid
      t.integer :user_id
      t.string :token
      t.string :secret
      t.string :handle

      t.timestamps
    end
  end
end
