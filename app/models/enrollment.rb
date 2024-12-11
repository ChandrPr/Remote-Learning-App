# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  grade      :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  course_id  :integer
#  student_id :integer
#
class Enrollment < ApplicationRecord

  validates :course_id, presence: true
  validates :student_id, presence: true
  validates :status, presence: true
  validates :status, inclusion: { in: [ "In Progress", "On Hold", "Passed", "Failed", "Incomplete" ] }
  validates :grade, numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: 0, allow_blank: true }
  validates :student_id, uniqueness: { scope: ["course_id"], message: "You have already enrolled for this course." }

  belongs_to :course
  belongs_to :student
  has_many  :questions, dependent: :destroy

end
