class AnalyticsController < ApplicationController
  def show
    @short_link = ShortLink.find_by(short_code: params[:short_code])
    unless @short_link.present?
      render :not_found
    end
  end

  def index
    @short_links = ShortLink.where(user_id: cookies.signed[:session_uuid]).order(short_code: :desc)
    if @short_links.empty?
      render :not_available
    end
  end
end
