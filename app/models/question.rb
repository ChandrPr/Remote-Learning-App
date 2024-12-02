# == Schema Information
#
# Table name: questions
#
#  id             :bigint           not null, primary key
#  body           :text
#  feedback       :text
#  score          :integer
#  student_answer :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  enrollment_id  :integer
#
class Question < ApplicationRecord

  validates :enrollment_id, presence: true
  validates :body, presence: true
  validates :score, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 0 }
  validates :body, uniqueness: { scope: ["enrollment_id"] }
    
  belongs_to :enrollment
  
end
