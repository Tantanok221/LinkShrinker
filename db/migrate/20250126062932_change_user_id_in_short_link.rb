class ChangeUserIdInShortLink < ActiveRecord::Migration[8.0]
  def change
    change_column :short_links, :user_id, :string
  end
end
