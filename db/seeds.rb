
(1..5).each do |n|
  User.where(user_name: "User#{n}").first_or_create!
end

User.find_each do |user|
  (1..3).each do |n|
    poll = Poll.where(title: "#{user.user_name} poll ##{n}").first_or_create! do |poll|
      poll.author = user
      poll.author_id = user.id
    end
    (1..4).each do |n|
      questions = poll.questions.where(body: "Question #{n} for poll #{poll.id} from #{poll.author.user_name}").first_or_create!
      (1..3).each do |m|
        case m
        when 1
          questions.answer_choices.where(answer: 'yes').first_or_create!
        when 2
          questions.answer_choices.where(answer: 'no').first_or_create!
        when 3
          questions.answer_choices.where(answer: 'maybe').first_or_create!
        end
      end
    end
  end
end


# Question.all.each do |question|
#     n = question.poll.author_id
#     user_ids = [1,2,3,4,5]
#     user_ids.delete(n)
#     Response.create!(respondent_id: user_ids.sample, answer_choice_id: question.answer_choices.sample.id)
# end
# Response.create!(respondent_id: 2, answer_choice_id: 1)
# Response.create!(respondent_id: 2, answer_choice_id: 4)
# Response.create!(respondent_id: 2, answer_choice_id: 7)
# Response.create!(respondent_id: 2, answer_choice_id: 10)

Response.create!(respondent_id: 3, answer_choice_id: 13)
Response.create!(respondent_id: 3, answer_choice_id: 16)
Response.create!(respondent_id: 3, answer_choice_id: 19)
Response.create!(respondent_id: 3, answer_choice_id: 22)
