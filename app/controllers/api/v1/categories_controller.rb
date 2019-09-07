module Api
  module V1
    class CategoriesController < Api::V1::ApiController
      def index
        @categories = Category.includes(:category_sounds).includes(:sounds).order(updated_at: :desc)
        @last_updated = Category.order(updated_at: :desc).limit(1)
        @deleted_categories = Category.where(deleted: true).pluck(:id)

        if params[:last_update].present? && last_updated_check == @last_updated_sound
          puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n============ #{"Push it"} ============\n\n\n\n\n\n\n\n"
          @last_updated
          @categories = Category.includes(:sounds).where('updated_at > ?', params[:last_update])
          puts "#{@last_updated[0].attribute_changed?(:updated_at)}"
        elsif params[:last_update].present? && last_updated_check == @last_updated_category
          puts "\n\n\n\n\n\n\n\n#{"Hello"}\n\n\n\n\n\n"
          @last_updated
          @categories = Category.includes(:sounds).where('updated_at > ?', params[:last_update])
        elsif last_updated_check == @last_updated_sound
          puts "\n\n\n\n\n\n\n\n#{"Hello World"}\n\n\n\n\n\n"
          @last_updated
          @categories
        elsif last_updated_check == @last_updated_category
          puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n============ #{"Super Puper"} ============\n\n\n\n\n\n\n\n"
          @last_updated
          @categories
        else
          head :no_content
        end
      end

      private

      def last_updated_check
        @last_updated_sound = Sound.order(updated_at: :desc).limit(1)
        @last_updated_category = Category.order(updated_at: :desc).limit(1)

        if @last_updated_sound.present? && @last_updated_category.present?
          if @last_updated_sound.pluck(:updated_at).pop > @last_updated_category.pluck(:updated_at).pop
            @last_updated_sound
          else
            @last_updated_category
          end
        else
          head :no_content
        end
      end
    end
  end
end
