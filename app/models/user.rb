class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable#, :validatable

  def email_required?
    false
  end

  def email_changed?
    false
  end

  has_many :questions


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

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
      data = access_token.info
      user = User.where(:email => data["email"]).first

      first_name = data["name"].split(" ")[0]
      last_name = data["name"].split(" ")[1]

      unless user
          user = User.create(first_name: first_name,
                             last_name: last_name,
                             email: data["email"],
                             password: Devise.friendly_token[0,20]
                            )
      end
      user
  end

  def self.find_for_twitter(oauth_info)
    info = oauth_info["info"]
    user = User.where(provider: :twitter, uid: oauth_info["uid"]).first

    first_name = info["name"].split(" ")[0]
    last_name  = info["name"].split(" ")[1]

    unless user
      Rails.logger.info ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      user = User.create!(first_name: first_name,
                          last_name: last_name,
                          password: Devise.friendly_token[0,20],
                          provider: :twitter,
                          uid: oauth_info["uid"])
    end
    user
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