class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.integer :enrollment_id
      t.text :question_body
      t.text :student_answer
      t.text :feedback
      t.integer :score

      t.timestamps
    end
  end
end
