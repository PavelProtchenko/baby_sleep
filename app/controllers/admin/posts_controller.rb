class Admin::PostsController < Admin::AdminController
  before_action :set_post, only: %w[edit update destroy publish_status]

  def index
    @posts = Post.search(params[:term]).paginate(page: params[:page], per_page: 25).order(position: :asc)
  end

  def new
    @post = Post.new(post_params)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to admin_posts_path, notice: 'Post was successfully created'
    else
      flash.now[:danger] = 'Post was not created'
      render :new
    end
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated'
    else
      flash.now[:danger] = 'Post was not updated'
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      if @post.destroy
        format.js
        format.html { redirect_to admin_posts_path, notice: 'Post was successfully deleted' }
      else
        format.js
        format.html { render :index }
      end
    end
  end

  def publish_status
    if @post.publication == 'published'
      @post.publication = 'un-unpublished'
      @post.save
      render json: { success: true }
    else
      flash.now[:danger] = 'Post has been already unpublished'
      render :index
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params
      .fetch(:post, {})
      .permit(:title, :body, :position, :publication, :image_url, :description,
              :term, categories_attributes: [:id, :name, :_destroy], category_ids: [])
  end
end
