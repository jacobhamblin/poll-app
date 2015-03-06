# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  respondent_id    :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base

  validate :ensure_unique_respondents, :cant_respond_to_own_poll

  belongs_to(
    :respondent,
    class_name: :User,
    foreign_key: :respondent_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: :AnswerChoice,
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    question.responses.where("responses.id != ?", self.id)
  end

  def ensure_unique_respondents
    if question.responses.exists?(respondent_id: self.respondent_id)
      errors[:user] << "can't respond to the same question twice"
    end
  end

  def cant_respond_to_own_poll
    if question.poll.author_id == self.respondent_id
      errors[:user] << "can't respond to own poll"
    end
  end
end
