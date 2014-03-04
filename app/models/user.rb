class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers

  has_many :likes
  has_many :liked_questions, through: :likes, source: :likeable, source_type: "Question"
  has_many :liked_answers, through: :likes, source: :likeable, source_type: "Answer"

  has_many :votes
  has_many :voted_questions, through: :votes, source: :question

  has_one :api_key

  before_create :generate_api_key

  def name_display
    if first_name || last_name
      "#{first_name} #{last_name}".strip
    else
      email
    end
  end

  def tester
    self
  end

  def vote_for question
    Vote.where(question: question, user: self).first
  end

  def like_for likeable
    likeable.likes.where(user_id: self).first
  end

  def has_liked? likeable
    case likeable
    when Question then liked_questions.include? likeable
    when Answer then liked_answers.include? likeable
    end
  end

  private

  def generate_api_key
    self.api_key = ApiKey.new
  end

end