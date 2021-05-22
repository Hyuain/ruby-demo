class Tag < ApplicationRecord
  has_many :taggings

  validates_presence_of :name
end
