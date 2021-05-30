class JobPost < ApplicationRecord
  belongs_to :user 
  
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :min_salary, numericality: { greater_than_or_equal_to: 30_000 }
  validates :location, presence: true

  scope :search, -> (query) {
    where("title ILIKE ? OR description ILIKE ? ", "%#{query}%", "%#{query}%")
    # where("title ILIKE ? ", "%#{query}%") # if you want to search just by title
  }
  # equivalent to:
  # def self.search(query)
  #   where("title ILIKE ? OR description ILIKE ? ", "%#{query}%", "%#{query}%")
  # end
end
