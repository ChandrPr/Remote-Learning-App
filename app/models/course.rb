# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  isactive      :boolean
#  name          :string
#  system_prompt :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  instructor_id :integer
#
class Course < ApplicationRecord

  validates :name, presence: { message: "Course Name is required." }
  validates :name, uniqueness: { message: "Course name has already been taken." }
  validates :isactive, presence: true
  validates :instructor_id, presence: true
  validates :system_prompt, presence: true

  has_many  :enrollments, dependent: :destroy
  has_many  :documents, dependent: :destroy
  has_many  :sample_questions, dependent: :destroy
  belongs_to :instructor

  has_many :students, through: :enrollments, source: :student

end
