class Movie < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  scope :recent_first, -> { order(created_at: :desc) }

  validates :synopsis, length: { maximum: 2000 }
  validates :release_year, numericality: { only_integer: true, greater_than_or_equal_to: 1888 }, allow_nil: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :director, length: { maximum: 100 }, allow_nil: true

  has_many :comments, dependent: :destroy

  has_one_attached :poster
  validate :poster_format

  private

  def poster_format
    return unless poster.attached?

    unless poster.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:poster, "precisa ser uma imagem JPEG, PNG ou GIF")
    end

    if poster.byte_size > 5.megabytes
      errors.add(:poster, "deve ser menor que 5MB")
    end
  end
end
