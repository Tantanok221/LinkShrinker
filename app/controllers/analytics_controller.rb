class AnalyticsController < ApplicationController
  def show
    @short_link = ShortLink.find_by!(short_code: params[:short_code])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Analytics not found"
  end

  def index
    @short_links = ShortLink.where(user_id: cookies.signed[:session_uuid])

  end
end