class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :lineage_id    #user id of first person
      t.integer :current_cohort_id
      # t.string :password_hash

      t.timestamps
    end
  end
end


