class DirectAuth < ApplicationRecord
  belongs_to :user
  has_secure_password

  def user_id
    user.id
  end

end
