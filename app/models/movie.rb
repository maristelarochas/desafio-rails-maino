class Movie < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  validates :synopsis, length: { maximum: 2000 }
  validates :release_year, numericality: { only_integer: true, greater_than_or_equal_to: 1888 }, allow_nil: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :director, length: { maximum: 100 }, allow_nil: true

  scope :recent_first, -> { order(created_at: :desc) }
end
