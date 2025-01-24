class AnalyticsController < ApplicationController
  def show
    @short_link = ShortLink.includes(:clicks).find_by!(short_code: params[:short_code])

    analytics_data = {
      time: {
        daily: @short_link.clicks.group_by_day(:created_at).count,
        weekly: @short_link.clicks.group_by_week(:created_at).count,
        monthly: @short_link.clicks.group_by_month(:created_at).count
      },
      geo: {
        country: @short_link.clicks.group(:country).count,
        region: @short_link.clicks.group(:region).count,
        city: @short_link.clicks.group(:city).count
      },
      referrers: @short_link.clicks.group(:referrer).count
    }

    respond_to do |format|
      format.html do
        render Analytic::MainComponent.new(
          short_link: @short_link,
          total_clicks: @short_link.clicks.count,
          time_data: analytics_data[:time],
          geo_data: analytics_data[:geo],
          referrer_data: analytics_data[:referrers]
        )
      end
      format.turbo_stream
    end

  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Analytics not found"
  end
end