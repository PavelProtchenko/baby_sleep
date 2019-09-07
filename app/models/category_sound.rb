class CategorySound < ApplicationRecord
  belongs_to :category, required: false
  belongs_to :sound, required: false

  after_save -> { Category.find(category_id).touch }
end
