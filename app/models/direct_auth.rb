class DirectAuth < ApplicationRecord
  belongs_to :user
  validates :email, :password, presence: true;

  def user_id
    user.id
  end
end
