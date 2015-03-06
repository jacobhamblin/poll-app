SELECT
        polls.*
      FROM
        polls
      JOIN
        questions ON polls.id = questions.poll_id
      JOIN
        answer_choices ON questions.id = answer_choices.question_id
      LEFT OUTER JOIN (
        SELECT
          *
        FROM
          responses
        WHERE
          respondent_id = 3
      ) AS responses ON answer_choices.id = responses.answer_choice_id
      GROUP BY
        polls.id
      HAVING
        COUNT(DISTINCT questions.id) = COUNT(responses.*)

-- SELECT *
-- FROM responses
-- JOIN users ON responses.respondent_id = users.id
-- where users.id = 1
-- order
