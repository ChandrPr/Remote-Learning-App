class ChangeTopicsToCourses < ActiveRecord::Migration[7.1]
  def change
    rename_table :topics, :courses
  end
end
