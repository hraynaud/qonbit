class User < ApplicationRecord
  has_many :blabs
  has_many :projects
  has_many :user_oauth_tokens

  def handle
    user_oauth_tokens.try(:first).handle
  end

  private

end
