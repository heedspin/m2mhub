class ContentModulesController < ApplicationController
  filter_access_to_defaults

  def edit
    @content_module = current_object
  end

  def update
    @content_module = current_object
    if @content_module.update_attributes(params[:content_module])
      flash.clear
      redirect_back_or_default root_url
    else
      render :action => 'edit'
    end
  end

  protected

    before_filter :set_banner
    def set_banner
      @banner = "/images/banners/home.jpg"
    end

end
