class FixResponseTable < ActiveRecord::Migration
  def change
    rename_column :responses, :user_id, :respondent_id
    remove_column :responses, :question_id
  end
end
