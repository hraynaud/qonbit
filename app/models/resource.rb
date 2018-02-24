class Resource < ApplicationRecord
  belongs_to :domain
  belongs_to :User
  belongs_to :specialist, :class_name => "User", :foreign_key => "specialist_id"

  enum status: [ :pending, :confirmed, :rejected, :canceled ]
end
