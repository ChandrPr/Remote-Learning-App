class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.integer :instructor_id
      t.boolean :isactive
      t.integer :enrollments_count

      t.timestamps
    end
  end
end
