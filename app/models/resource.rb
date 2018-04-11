class Resource < ApplicationRecord
  belongs_to :domain
  belongs_to :user
  belongs_to :specialist, :class_name => "User", :foreign_key => "specialist_id"

  enum status: [ :pending, :confirmed, :rejected, :canceled ]

  validate :user_and_specialist_must_be_different

  def user_and_specialist_must_be_different
    errors.add(:base, "You cannot add yourself as a resource") if specialist == user
  end


  def resource_accepted
    #This will eventually be wrapped in a resque worker
    return if resource.is_pending?

    if resource.is_accepted?
      ImpressionEvent.create(:eventable=>resource)
      RelationshipManager.register_skill_with_root_node(resource)
      RelationshipManager.create_friendship_if_none_exists(resource)
      RelationshipManager.establish_following_relationship(resource)
    end

      #ScoreKeeper.update_scores(impression)
  end

end
