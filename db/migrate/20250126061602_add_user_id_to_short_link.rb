class AddUserIdToShortLink < ActiveRecord::Migration[8.0]
  def change
    add_column :short_links, :user_id, :integer
  end
end
