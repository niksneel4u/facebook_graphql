class CreateFavGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :fav_groups do |t|

      t.references :user, foreign_key: true
      t.string :key
      t.string :group_id
      t.timestamps
    end
  end
end
