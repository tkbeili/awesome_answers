class Question < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  mount_uploader :image, ImageUploader

  # has_attached_file :image, 
  #                   styles: {thumb: "50x50>", medium: "100x100>", large: "300x300" },
  #                   default_url: ActionController::Base.helpers.asset_path('missing_:style.png')

  
  # validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


  has_many :categorizations
  has_many :categories, through: :categorizations

  has_many :answers
  belongs_to :user

  has_many :likes, as: :likeable
  has_many :likers, through: :likes, source: :user

  has_many :votes
  has_many :voted_users, through: :votes, source: :user


  validates_presence_of :title, :body

  scope :recent, -> { where(["created_at > ?", Time.now - 10.days]) }
  scope :ten,    -> { limit(10) }
  scope :all_but, lambda {|ids| where(["id not in (?)", ids])}
  scope :recent_ten, -> { recent.ten }

  default_scope { order("questions.updated_at DESC") }

  before_save :upcase_title

  # def should_generate_new_friendly_id?
  #   new_record?
  # end

  def like_by user
    likers << user && change_like_count(1)
  end

  def unlike_by user
    likers.delete(user)
    change_like_count(-1) if like_count > 0
  end

  def update_vote_count
    self.votes_count = votes.up.count - votes.down.count
    save
  end

  private

  def change_like_count amount
    self.like_count += amount
    save!
  end

  def upcase_title
    self.title.upcase!
  end

end