class CreateUrlAccesses < ActiveRecord::Migration[6.1]
  def change
    create_table :url_accesses do |t|
      t.references :short_url, null: false, foreign_key: true

      t.timestamps
    end
  end
end
