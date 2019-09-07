json.updated_at @last_updated[0]['updated_at'].strftime('%Y-%m-%d %H:%M:%S.%6N')
json.updated @categories.each do |category|
  if category.deleted == false
    json.id category.id
    json.title category.title
    json.subtitle category.subtitle
    json.image_url category.image_url.url
    json.main_image_url category.main_image_url.url
    json.position category.position
    json.onboarding category.onboarding
    json.default_sounds_title category.default_sounds_title
    json.sounds category.sounds.where(deleted: false).includes(:category_sounds).each do |sound|
      CategorySound.where(category_id: category.id).where(sound_id: sound.id).each do |cs|
        json.id sound.id
        json.name sound.name
        json.image_url sound.image_url.url
        json.file_url sound.file_url.url
        json.popular sound.popular
        json.position cs.position
        json.lock cs.lock
      end
    end
    json.mixes category.mixes.each do |mix|
      json.id mix.id
      json.name mix.name
      json.image_url mix.image_url
      json.duration mix.duration
      json.position mix.position
      json.volume mix.volume
    end
  end
end
json.deleted @deleted_categories
