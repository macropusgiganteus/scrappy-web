class CreateKeywordResults < ActiveRecord::Migration[7.1]
  def change
    create_table :keyword_results do |t|
      t.references :keyword, null: false, foreign_key: true
      t.bigint :total_ads
      t.bigint :total_links
      t.string :total_search_results
      t.string :html

      t.timestamps
    end
  end
end
