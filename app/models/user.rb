class User < ApplicationRecord
  has_many :projects, dependent: :destroy
  has_many :user_oauth_tokens, dependent: :destroy
  has_one  :direct_auth, dependent: :destroy
  has_one  :profile

  validates :direct_auth, presence: true, if: :oauth_tokens_missing?
  validates_associated :direct_auth, allow_mil: true


  delegate :friends, :friends_with?, :follows?, :follow, :unfollow, :followers, :following, :block, :blocks?, to: :relationship_mgr
  delegate :first_name, :last_name, :name, to: :profile

  accepts_nested_attributes_for :direct_auth
  accepts_nested_attributes_for :profile

  before_create :build_profile

  after_create :add_to_social_graph

  def self.create_with_direct_auth email, pwd, is_member=true
    create(is_member: is_member, direct_auth_attributes:{email: email , password: pwd})
  end

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
    @node ||= SocialGraph::Membership.get_user_node self
  end

  private

  def relationship_mgr
    @mgr ||= SocialGraph::UserToNodeAdapter.new self
  end

  def add_to_social_graph
    SocialGraph::Membership.add_to_social_graph self
  end

  def remove_from_social_graph
    SocialGraph::Membership.remove_node_for_user self
  end

  def oauth_tokens_missing?
    user_oauth_tokens.empty?
  end
end
