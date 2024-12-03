# == Schema Information
#
# Table name: documents
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#
class Document < ApplicationRecord

  validates :course_id, presence: true
  
  belongs_to :course

end
