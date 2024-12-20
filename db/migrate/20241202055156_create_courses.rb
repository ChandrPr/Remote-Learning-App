class CreateCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :instructor_id
      t.boolean :isactive
      t.text :system_prompt

      t.timestamps
    end
  end
end
