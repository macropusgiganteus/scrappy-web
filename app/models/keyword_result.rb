class KeywordResult < ApplicationRecord
  belongs_to :keyword
  validates :total_ads, presence: true
  validates :total_links, presence: true
  validates :total_search_results, presence: true
  validates :html, presence: true
end
