class AnalyticsController < ApplicationController
  def show
    @short_link = ShortLink.includes(:clicks).find_by!(short_code: params[:short_code])
    @total_clicks = @short_link.clicks.count
    @clicks_by_day = @short_link.clicks.group_by_day(:created_at).count
    @clicks_by_country = @short_link.clicks.group(:country).count
    @clicks_by_region = @short_link.clicks.group(:region).count
    @clicks_by_city = @short_link.clicks.group(:city).count
    @clicks_by_referrer = @short_link.clicks.group(:referrer).count
    respond_to do |format|
      format.html
      format.turbo_stream
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Analytics not found"
  end
end

def analytics_params
  params.require(:short_link).permit(:short_code)
end
