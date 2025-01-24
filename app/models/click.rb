class Click < ApplicationRecord
  belongs_to :short_link
  after_create_commit :broadcast_analytics_update

  private

  def broadcast_analytics_update
    Turbo::StreamsChannel.broadcast_update_to(
      "analytic/#{short_link.short_code}",
      target: "analytics",
      html: ApplicationController.render(
        AnalyticsComponent.new(
          short_link: short_link,
          total_clicks: short_link.clicks.count,
          time_data: {
            daily: short_link.clicks.group_by_day(:created_at).count,
            weekly: short_link.clicks.group_by_week(:created_at).count,
            monthly: short_link.clicks.group_by_month(:created_at).count
          },
          geo_data: {
            country: short_link.clicks.group(:country).count,
            region: short_link.clicks.group(:region).count,
            city: short_link.clicks.group(:city).count
          },
          referrer_data: short_link.clicks.group(:referrer).count
        ),
        layout: false
      ),

    )
  end
end
