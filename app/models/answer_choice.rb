# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  question_id :integer
#  answer      :text
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoice < ActiveRecord::Base
  validates :answer, presence: true

  belongs_to(
    :question,
    class_name: :Question,
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: :Response,
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_many(
    :users,
    through: :responses,
    source: :respondent
  )
end
