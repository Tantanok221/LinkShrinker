# app/controllers/short_links_controller.rb
class ShortLinksController < ApplicationController
  def create
    @short_link = ShortLink.new(short_link_params)
    if @short_link.save
      redirect_to @short_link
    else
      render 'home/index'
    end
  end

  def show
    @short_link = ShortLink.find(params[:id])
  end

  def redirect
    @short_link = ShortLink.find_by(short_code: params[:short_code])
    @short_link.increment!(:clicks_count)
    Click.create!(short_link: @short_link, ip_address: request.remote_ip)
    redirect_to @short_link.target_url, allow_other_host: true
  end

  private

  def short_link_params
    params.require(:short_link).permit(:target_url)
  end
end