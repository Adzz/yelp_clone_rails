class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy

  belongs_to :user

  validates :name, length: {minimum: 3}, uniqueness: true

  def average_rating
    return 'N/A' if reviews.none?
    avg = reviews.inject(0) {|memo, review| memo + review.rating} / reviews.length
    avg.ceil
  end

  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end
end
