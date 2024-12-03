# == Schema Information
#
# Table name: sample_questions
#
#  id            :bigint           not null, primary key
#  question_body :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  course_id      :integer
#
class SampleQuestion < ApplicationRecord

  belongs_to :course

end
