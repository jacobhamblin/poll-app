class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.belongs_to :question
      t.text :answer

      t.timestamps
    end
  end
end
