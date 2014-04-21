class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  has_many :comments

  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user

  validates_presence_of :body

  before_save :capitalize

  def like_by user
    self.likers << user
  end

  def unlike_by user
    likers.delete(user)
  end

  private

  def capitalize
    self.body.capitalize!
  end

end