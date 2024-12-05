# == Schema Information
#
# Table name: sample_questions
#
#  id            :bigint           not null, primary key
#  question_body :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  course_id     :integer
#
class SampleQuestion < ApplicationRecord

  validates :question_body, presence: true
  validates :question_body, uniqueness: { scope: ["course_id"] }

  belongs_to :course

end
