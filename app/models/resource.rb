class Resource < ApplicationRecord
  belongs_to :domain
  belongs_to :User
  belongs_to :specialist, :class_name => "User", :foreign_key => "specialist_id"
end
