class Admin::UsersController < Admin::AdminController
  def index
    redirect_to admin_sounds_path
  end
end
