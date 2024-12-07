# == Schema Information
#
# Table name: messages
#
#  id            :bigint           not null, primary key
#  body          :text
#  feedback      :text
#  role          :string
#  score         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  enrollment_id :integer
#
class Message < ApplicationRecord

  validates :body, presence: true
  validates :role, presence: true
  validates :role, inclusion: { in: [ "system", "user", "assistant" ] }

  belongs_to :enrollment


end
