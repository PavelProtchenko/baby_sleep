class Sound < ApplicationRecord
  has_many :category_sounds
  has_many :categories, through: :category_sounds, dependent: :destroy
  has_many :mix_sounds
  has_many :mixes, through: :mix_sounds

  after_save -> { category_sounds.each { |cat| Category.find(cat.category_id).touch } }

  validates :name, presence: true
  mount_uploader :image_url, SoundImageUploader
  mount_uploader :file_url, AudioUploader
  accepts_nested_attributes_for :categories

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%")
    else
      all
    end
  end
end
