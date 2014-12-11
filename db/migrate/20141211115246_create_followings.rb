class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |t|
      t.belongs_to :user
      t.integer :follower_id

      t.timestamps
    end
  end
end
