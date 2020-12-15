class AddIndexToFavGroup < ActiveRecord::Migration[6.0]
  def change
    add_index :fav_groups, %i[user_id group_id], unique: true
  end
end
