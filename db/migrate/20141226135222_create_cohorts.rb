class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :name
      t.date :graduation_date
      # t.integer :mentor_line    #user id of first person
      # t.string :password_hash

      t.timestamps
    end
  end
end
