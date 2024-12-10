# == Schema Information
#
# Table name: questions
#
#  id             :bigint           not null, primary key
#  feedback       :text
#  question_body  :text
#  score          :integer
#  student_answer :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  enrollment_id  :integer
#
class Question < ApplicationRecord

  validates :enrollment_id, presence: true
  validates :question_body, presence: true
  validates :score, numericality: { less_than_or_equal_to: 5, greater_than_or_equal_to: 0, allow_blank: true }
  
  belongs_to :enrollment
  
end
