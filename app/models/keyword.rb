class Keyword < ApplicationRecord
  belongs_to :user
  has_one :keyword_result
end
