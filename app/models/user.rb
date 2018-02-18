class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :user_oauth_tokens, dependent: :destroy
  has_one  :direct_auth, dependent: :destroy

  validates_associated :direct_auth, allow_mil: true

  def handle
    user_oauth_tokens.try(:first).handle
  end

  def auth_email
    direct_auth.email
  end

  private

end
