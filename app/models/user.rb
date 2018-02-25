class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :user_oauth_tokens, dependent: :destroy
  has_one  :direct_auth, dependent: :destroy

  validates_associated :direct_auth, allow_mil: true

  after_create :add_to_social_graph

  delegate :add_friend, :friends, :befriend, :friends_with?, :follows?, :follow, :unfollow, :followers, :following, :block, :blocks?, to: :as_node

  def handle
    user_oauth_tokens.try(:first).handle
  end

  def auth_email
    direct_auth.email
  end

  def name
    "#{first_name} #{last_name}"
  end

  def as_node
    @node ||= SocialGraph.get_user_node self
  end

  private

  def add_to_social_graph
    SocialGraph.add_node_for_user self
  end

  def remove_from_social_graph
    SocialGraph.remove_node_for_user self
  end
end
