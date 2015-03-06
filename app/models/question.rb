# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  poll_id    :integer
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  validates :body, presence: true

  belongs_to(
    :poll,
    class_name: :Poll,
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: :AnswerChoice,
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses


  # def results
  #   hash = Hash.new(0)
  #   responses.each do |response|
  #     hash[response.answer_choice.answer] += 1
  #   end
  #
  #   hash
  # end

  # def results
    # responses
  #   .select('answer_choices.answer, COUNT(*) AS davidscount')
  #   .joins(:answer_choice)
  #   .group('answer_choices.id')
  # end

  def results
    responses
      .includes(answer_choices)
      .group(:answer)
      .count
  end

end
