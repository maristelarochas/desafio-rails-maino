class MovieCategory < ApplicationRecord
  belongs_to :movie
  belongs_to :category

  validates :category_id, uniqueness: { scope: :movie_id }
end
