# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many(
    :polls,
    class_name: :Poll,
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :responses,
    class_name: :Response,
    foreign_key: :respondent_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    through: :responses,
    source: :answer_choice
  )

  def completed_poll
    polls.find_by_sql([<<-SQL, id: self.id])
    SELECT
      polls.*
    FROM
      polls
    LEFT OUTER JOIN
      questions ON questions.poll_id = polls.id
    LEFT OUTER JOIN
      answer_choices ON answer_choices.question_id = questions.id
      LEFT OUTER JOIN (
         SELECT
           *
         FROM
           responses
         WHERE
           respondent_id = 14
       ) AS responses ON answer_choices.id = responses.answer_choice_id
    GROUP BY
      polls.id
    HAVING
      COUNT(DISTINCT(responses.*)) = COUNT(responses.id)


      SELECT
        questions.poll_id, count(DISTINCT(questions.q_id)) as question_count
      FROM (SELECT
          answer_choice_questions.*
        FROM (SELECT
                questions.id as q_id, questions.poll_id as poll_id, answer_choices.id as answerchoice_id, answer_choices.answer
              FROM
                questions
              JOIN
                answer_choices ON answer_choices.question_id = questions.id) as answer_choice_questions
        JOIN
          responses ON answer_choice_questions.answerchoice_id = responses.answer_choice_id
        JOIN
          users ON responses.respondent_id = users.id
        WHERE
          users.id = 1) AS questions
      GROUP BY
        questions.poll_id
      HAVING
        COUNT(*) = COUNT(responses.id)

    SQL

  end

end
