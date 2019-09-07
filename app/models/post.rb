class Post < ApplicationRecord
  has_many :categories, as: :categorizable

  validates :title, presence: true
  mount_uploader :image_url, PostImageUploader

  def self.search(term)
    if term
      where('title LIKE ?', "%#{term}%")
    else
      all
    end
  end
end
