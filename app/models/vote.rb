class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates :user_id, uniqueness: {scope: :question_id}
  
  scope :up,   -> { where(is_up: true) }
  scope :down, -> { where(is_up: false) }

  after_save :update_question_vote_count
  after_destroy :update_question_vote_count

  def is_down?
    !is_up?
  end

  private

  def update_question_vote_count
    question.update_vote_count
  end

end
