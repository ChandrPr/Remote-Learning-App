# == Schema Information
#
# Table name: documents
#
#  id           :bigint           not null, primary key
#  doc_url      :string
#  doctype      :string
#  name         :string
#  uploadto_llm :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  course_id    :integer
#
class Document < ApplicationRecord

  mount_uploader :doc_url, DocumentUploader

  validates :name, presence: true
  validates :name, uniqueness: { scope: ["course_id"] }
#  validates :doc_url, uniqueness: { scope: ["course_id"], conditions: -> { where.not(doc_url: '') } }
  validates :course_id, presence: true
  validates :doctype, presence: true
  validates :doctype, inclusion: { in: [ "pdf", "jpeg", "html", "docx" ] }
  
  belongs_to :course

end
