class Admin::SoundsController < Admin::AdminController
  before_action :set_sound, only: %w[edit update destroy deleted_status regenerated_status]

  def index
    Sound.all.each do |sound|
      if sound.deleted == false
        @sounds = []
        @sounds << sound
        @sounds = Sound.search(params[:term]).paginate(page: params[:page], per_page: 25).where(deleted: false).order(created_at: :desc)
      elsif sound.deleted == true
        @deleted_sounds = []
        @deleted_sounds << sound
        @deleted_sounds = Sound.search(params[:term]).where(deleted: true).order(created_at: :desc)
      end
    end
  end

  def deleted_sounds
    @deleted_sounds = Sound.paginate(page: params[:page], per_page: 25).where(deleted: true).order(updated_at: :desc)
  end

  def new
    @sound = Sound.new(sound_params)
    @sound.categories.build
  end

  def edit
  end

  def create
    @sound = Sound.new(sound_params)
    respond_to do |format|
      if @sound.save
        format.js {}
        format.html { redirect_to admin_sounds_path, notice: 'Sound was successfully created' }
      else
        flash.now[:danger] = 'Sound was not created'
        render :index
      end
    end
  end

  def deleted_status
    if @sound.deleted == false
      @sound.deleted = true
      @sound.save
      render json: { success: true }
    else
      flash.now[:danger] = 'Sound has been already deleted'
      render :index
    end
  end

  def regenerated_status
    if @sound.deleted == true
      @sound.deleted = false
      @sound.save
      redirect_to deleted_sounds_admin_sounds_url, notice: 'Sound was successfully regenerated'
    else
      flash.now[:danger] = 'Sound has been alread regenerated'
    end
  end

  def update
    respond_to do |format|
      if @sound.update(sound_params)
        format.js {}
        format.html { redirect_to admin_sounds_path, notice: 'Sound was successfully updated' }
      else
        flash.now[:danger] = 'Sound was not updated'
        format.js {}
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @sound.destroy
        format.js
        format.html { redirect_to admin_sounds_path, success: 'Sound was successfully deleted' }
      else
        format.js
        format.html { render :index }
      end
    end
  end

  private

  def set_sound
    @sound = Sound.find(params[:id])
  end

  def sound_params
    params
      .fetch(:sound, {})
      .permit(:name, :image_url, :file_url, :category_id, :parent_id, :popular, :lock,
              :term, category_attributes: [:id, :name, :_destroy], category_ids: [])
  end
end
