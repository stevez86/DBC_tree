class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :mentor_line    #user id of first person
      t.string :password_hash

      t.timestamps
    end
  end
end


# cohort
# -name
# -graduation date

