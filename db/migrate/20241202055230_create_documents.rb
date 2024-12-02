class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.integer :topic_id

      t.timestamps
    end
  end
end
