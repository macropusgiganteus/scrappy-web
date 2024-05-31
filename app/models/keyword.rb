class Keyword < ApplicationRecord
  belongs_to :user
  has_one :keyword_result
  validates :keyword, presence: true
end
