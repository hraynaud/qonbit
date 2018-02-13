class DirectAuth < ApplicationRecord
  belongs_to :user
  validates :email, :password, presence: true;
  has_secure_password

  def user_id
    user.id
  end

end
