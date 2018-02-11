class UserOauthToken < ApplicationRecord
  belongs_to :user, optional: true

  def user_id
    user && user.id
  end

end
