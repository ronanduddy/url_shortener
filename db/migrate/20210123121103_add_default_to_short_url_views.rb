class AddDefaultToShortUrlViews < ActiveRecord::Migration[6.1]
  def change
    change_column_default(
      :short_urls,
      :views,
      from: nil,
      to: 0
    )
  end
end
