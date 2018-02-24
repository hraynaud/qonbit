class Domain < ApplicationRecord
  has_many :resources
  has_many :specialists, :through=>:resources
end
