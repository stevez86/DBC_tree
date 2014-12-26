class CreateCohortsUsers < ActiveRecord::Migration
  def change
    create_table :cohorts_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :cohort, index: true

      t.timestamps
    end
  end
end
