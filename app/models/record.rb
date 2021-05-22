class Record < ApplicationRecord
  paginates_per 10

  enum category: { outgoings: 1, income: 2 }
  validates_presence_of :amount, :category
end
