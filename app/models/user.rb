class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers

  has_many :likes
  has_many :liked_questions, through: :likes, source: :question

  has_many :votes
  has_many :voted_questions, through: :likes, source: :question

  def name_display
    if first_name || last_name
      "#{first_name} #{last_name}".strip
    else
      email
    end
  end

  def vote_for question
    Vote.where(question: question, user: self).first
  end

  def like_for question
    likes.where(question_id: question.id).first
  end

  def has_liked? question
    liked_questions.include? question
  end

end