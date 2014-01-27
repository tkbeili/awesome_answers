class Question < ActiveRecord::Base
  has_many :categorizations
  has_many :categories, through: :categorizations


  has_many :answers


  validates_presence_of :title, :body

  scope :recent, -> { where(["created_at > ?", Time.now - 10.days]) }
  scope :ten,    -> { limit(10) }
  scope :all_but, lambda {|ids| where(["id not in (?)", ids])}
  scope :recent_ten, -> { recent.ten }

  default_scope { order("updated_at DESC") }

  before_save :upcase_title

  private

  def upcase_title
    self.title.upcase!
  end

end