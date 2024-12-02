class CreateSampleQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :sample_questions do |t|
      t.text :question_body
      t.integer :topic_id

      t.timestamps
    end
  end
end
