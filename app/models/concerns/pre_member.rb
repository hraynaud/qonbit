class PreMember
  def self.create email
    User.create_with_direct_auth email, SecureRandom.base64(12), false
  end
end
