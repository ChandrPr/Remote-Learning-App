class CreateDocuments < ActiveRecord::Migration[7.1]
  def change
    create_table :documents do |t|
      t.integer :topic_id
      t.string :name
      t.string :doc_url
      t.string :doctype
      t.boolean :uploadto_llm

      t.timestamps
    end
  end
end
