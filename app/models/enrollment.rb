# == Schema Information
#
# Table name: enrollments
#
#  id         :bigint           not null, primary key
#  grade      :integer
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  student_id :integer
#  topic_id   :integer
#
class Enrollment < ApplicationRecord

  validates :topic_id, presence: true
  validates :student_id, presence: true
  validates :status, presence: true
  validates :status, inclusion: { in: [ "In Progress", "On Hold", "Passed", "Failed", "Incomplete" ] }
  validates :grade, numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: 0 }

  belongs_to :topic, counter_cache: true
  belongs_to :student, counter_cache: true
  has_many  :questions, dependent: :destroy

end
