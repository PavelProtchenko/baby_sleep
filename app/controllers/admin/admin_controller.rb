class Admin::AdminController < ApplicationController
  before_action :authenticate_user!

  layout 'admin'

  protected

  def default_url_options
    if I18n.locale == I18n.default_locale
      {}
    else
      { locale: I18n.locale }
    end
  end
end
