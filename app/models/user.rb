class User < ApplicationRecord
  has_many :blabs
  has_many :projects
  has_many :user_oauth_tokens
  has_one :user_login_pwd_auth
  validates_associated :user_login_pwd_auth

  def handle
    user_oauth_tokens.try(:first).handle
  end

  private

end
