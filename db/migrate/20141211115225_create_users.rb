class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :email
      t.string :profile_image
      t.string :password_hash

      t.integer :lineage_id
      t.integer :mentor_id
      t.integer :cohort_id
      t.integer :liprofile_id

      t.timestamps
    end

    add_index :users, :mentor_id
    add_index :users, :cohort_id
  end
end


