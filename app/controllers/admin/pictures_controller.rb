class Admin::PicturesController < Admin::AdminController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    @picture = Picture.new(image_params)
    @picture.save
    respond_to do |format|
      format.json { render json: { url: @picture.body_image_url.url, picture_id: @picture.id } }
    end
  end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    respond_to do |format|
      format.json { render json: { status: :ok } }
    end
  end

  private

  def image_params
    params.require(:picture).permit(:body_image_url)
  end
end
