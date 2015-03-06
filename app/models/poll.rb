# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  author     :string
#  title      :string
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  validates :author, :title, presence: true


  has_many(
    :questions,
    class_name: :Question,
    foreign_key: :poll_id,
    primary_key: :id
  )

  belongs_to(
   :author,
   class_name: :User,
   foreign_key: :author_id,
   primary_key: :id
  )

end
