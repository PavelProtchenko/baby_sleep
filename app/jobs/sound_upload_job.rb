class SoundUploadJob < ApplicationJob
  queue_as :default

  def self.perform(sound_id)
    sound = Sound.find(sound_id)
    # file.save
    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n#{sound} hello"
  end
end
