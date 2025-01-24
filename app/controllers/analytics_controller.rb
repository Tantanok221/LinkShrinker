class AnalyticsController < ApplicationController
  def show
    @short_link = ShortLink.find_by!(short_code: params[:short_code])
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Analytics not found"
  end
end