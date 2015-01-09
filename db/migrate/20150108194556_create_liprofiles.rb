class CreateLiprofiles < ActiveRecord::Migration
  def change
    create_table :liprofiles do |t|

      t.string :name
      t.string :email
      t.string :profile_url
      t.string :token
      t.string :location
      t.string :headline

      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
