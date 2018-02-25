class Resource < ApplicationRecord
  belongs_to :domain
  belongs_to :user
  belongs_to :specialist, :class_name => "User", :foreign_key => "specialist_id"

  enum status: [ :pending, :confirmed, :rejected, :canceled ]

  validate :user_and_specialist_must_be_different

  def user_and_specialist_must_be_different
    errors.add(:base, "You cannot add yourself as a resource") if specialist == user
  end

end
