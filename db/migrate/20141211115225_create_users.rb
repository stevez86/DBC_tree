class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :name
      t.string :email
      t.string :profile_url
      t.string :hometown

      t.integer :lineage_id
      t.belongs_to :mentor, index: true
      t.belongs_to :cohort, index: true

      t.timestamps
    end
  end
end


