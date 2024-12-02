# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#
class Document < ApplicationRecord

  validates :topic_id, presence: true
  
  belongs_to :topic

end
