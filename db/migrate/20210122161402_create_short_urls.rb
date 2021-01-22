class CreateShortUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :short_urls do |t|
      t.string :url
      t.string :slug
      t.bigint :views
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
