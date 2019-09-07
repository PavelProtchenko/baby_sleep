class AppsflyerWorker
  include Sidekiq::Worker

  def perform(params)
    AppsflyerService.new(params).call
    # sound = Sound.find(id)
    # { sound_url: sound.file_url,
    #   sound_name: sound.name,
    #   sound_image: sound.image_url,
    #   sound_deleted: sound.deleted,
    #   sound_populr: sound.popular
    # }.to_json
  end
end
