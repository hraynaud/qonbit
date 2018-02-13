class User < ApplicationRecord
  has_many :blabs
  has_many :projects
  has_many :user_oauth_tokens
  has_one  :direct_auth
  validates_associated :direct_auth

  def handle
    user_oauth_tokens.try(:first).handle
  end

  def auth_email
    direct_auth.email
  end

  private

end
