class CreateMentorsMentees < ActiveRecord::Migration
  def change
    create_table :mentor_mentors, id: false do |t|
      t.integer :mentor_id
      t.integer :mentee_id

      t.timestamps
    end
  end
end
