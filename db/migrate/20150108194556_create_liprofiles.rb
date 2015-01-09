class CreateLiprofiles < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :email
      t.string :profile_url
      t.string :token
      t.string :location
      t.string :headline

      t.integer :user_id

      t.timestamps
    end
  end
end
