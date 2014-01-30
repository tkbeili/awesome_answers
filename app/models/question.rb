class Question < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :answers
  belongs_to :user

  has_many :likes
  has_many :likers, through: :likes, source: :user

  has_many :votes
  has_many :voted_users, through: :likes, source: :user

  validates_presence_of :title, :body

  scope :recent, -> { where(["created_at > ?", Time.now - 10.days]) }
  scope :ten,    -> { limit(10) }
  scope :all_but, lambda {|ids| where(["id not in (?)", ids])}
  scope :recent_ten, -> { recent.ten }

  default_scope { order("questions.updated_at DESC") }

  before_save :upcase_title

  def like_by user
    likers << user && increment_likes(1)
  end

  def unlike_by user
    likers.delete(user) && increment_likes(-1)
  end

  def update_vote_count
    self.votes_count = votes.up.count - votes.down.count
    save
  end

  private

  def increment_likes amount
    self.like_count += amount
    save
  end

  def upcase_title
    self.title.upcase!
  end

end