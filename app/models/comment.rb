class Comment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :movie

  validates :content, presence: true, length: { minimum: 3, maximum: 500 }
  validates :author_name, presence: true, if: -> { user_id.nil? }

  scope :recent_first, -> { order(created_at: :desc) }

  def author
    user ? user.username : author_name
  end
end
