class AddDocumentDataToDocuments < ActiveRecord::Migration[7.1]
  def change
    add_column :documents, :doc_url, :string
    add_column :documents, :doctype, :string
    add_column :documents, :uploadto_llm, :boolean
  end
end
