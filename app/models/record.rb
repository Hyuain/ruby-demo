class Record < ApplicationRecord
  paginates_per 10

  belongs_to :user

  has_many :taggings
  has_many :tags, through: :taggings

  enum category: { outgoings: 1, income: 2 }
  validates_presence_of :amount, :category
end
