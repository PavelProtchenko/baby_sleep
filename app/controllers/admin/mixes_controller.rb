class Admin::MixesController < Admin::AdminController
  before_action :set_mix, only: [:show, :edit, :update, :destroy]

  def index
    @mixes = Mix.includes(:sounds).order(created_at: :desc).search(params[:term])
    # @mixes = Mix.includes(:sounds).includes(:categories).includes(:sound_categories).order(created_at: :desc).search(params[:term])
  end

  def new
    @mix = Mix.new(mix_params)
  end

  def edit
  end

  def create
    @mix = Mix.new(mix_params)

    if @mix.save
      redirect_to admin_mixes_path, notice: 'Mix was successfully created'
    else
      render :new
    end
  end

  def update
    if @mix.update_attributes(mix_params)
      redirect_to admin_mixes_path, notice: 'Mix was successfully updated'
    else
      flash.now[:danger] = 'Mix was not updated'
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @mix.destroy
        format.js
        format.html { redirect_to admin_mixes_path, notice: 'Mix was successfully deleted' }
      else
        format.js
        format.html { render :index }
      end
    end
  end

  private

  def set_mix
    @mix = Mix.find(params[:id])
  end

  def mix_params
    params
      .fetch(:mix, {})
      .permit(:name, :image_url, :duration, :position, :volume, :term,
              sound_ids: [], sounds_attributes: [:id, :sound_id, :mix_id, :mix_volume, :_destroy],
              sound_categories_attributes: [:id, :sound_id, :category_id, :_destroy], category_ids: [])
  end
end
