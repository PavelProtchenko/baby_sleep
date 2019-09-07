class Admin::CategoriesController < Admin::AdminController
  before_action :set_category, only: %w[show edit destroy update deleted_status regenerated_status update_position]

  def index
    @categories = Category.includes(:category_sounds).includes(:sounds).order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def update
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully updated'
    else
      flash.now[:danger] = 'Category was not updated'
      render :edit
    end
  end

  def update_position
    # Need to realize
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created'
    else
      flash.now[:danger] = 'Category was not created'
      render :new
    end
  end

  def destroy
    respond_to do |format|
      format.js
      if @category.destroy
        format.js
        format.html { redirect_to admin_categories_path, success: 'Category was successfully deleted' }
      else
        format.js
        format.html { render :index }
      end
    end
  end

  def deleted_status
    if @category.deleted == false
      @category.deleted = true
      @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully deleted'
    else
      flash.now[:danger] = 'Category has been already deleted'
      render :index
    end
  end

  def regenerated_status
    if @category.deleted == true
      @category.deleted = false
      @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully regenerated'
    else
      flash.now[:danger] = 'Category has been alread regenerated'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params
      .fetch(:category, {})
      .permit(:title, :subtitle, :position, :onboarding, :image_url,
              :categorizable_id, :sound_type, :default_sounds_title,
              :main_image_url, sound_attributes: [:id, :name],
              sounds_attributes: [:id, :name, :_destroy], category_sounds_attributes: [:id, :position, :lock, :sound_id, :category_id, :_destroy], sound_ids: [])
  end

  def category_sounds_params
    params.permit(:id, :sound_id, :category_id, :position, :update)
  end
end
