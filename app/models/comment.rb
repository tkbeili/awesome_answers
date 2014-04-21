class Comment < ActiveRecord::Base
  belongs_to :answer

  validates :body, presence: true, length: {minimum: 4}

  scope :recent_ten, -> { order("created_at DESC").limit(10) }

  def sanitaize
    self.body.squeeze!(" ")
  end

end
