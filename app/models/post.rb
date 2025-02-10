class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 1500 }
  validates :publish_date, presence: true

  scope :featured, -> { where(feature: true) }
  scope :active, -> { where(active: true) }
end