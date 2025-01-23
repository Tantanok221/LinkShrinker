class CreateClicks < ActiveRecord::Migration[8.0]
  def change
    create_table :clicks do |t|
      t.references :short_link, null: false, foreign_key: true
      t.string :ip_address
      t.string :country
      t.string :region
      t.string :city
      t.string :user_agent
      t.string :referrer

      t.timestamps
    end
  end
end
