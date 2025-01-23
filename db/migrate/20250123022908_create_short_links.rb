class CreateShortLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :short_links do |t|
      t.text :target_url
      t.string :short_code
      t.string :title
      t.integer :clicks_count

      t.timestamps
    end
    add_index :short_links, :short_code
  end
end
