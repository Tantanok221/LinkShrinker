class Click < ApplicationRecord
  belongs_to :short_link
  after_create_commit :broadcast_analytics_update
  after_save :invalidate_analytics_cache

  private

  def broadcast_analytics_update
    Turbo::StreamsChannel.broadcast_update_to(
      "analytic/#{short_link.short_code}",
      target: "analytics",
      html: ApplicationController.render(
        AnalyticsComponent.new(analytics_data: short_link.analytics_data),
        layout: false
      ),
    )
  end

  def invalidate_analytics_cache
    Rails.cache.delete("analytics_#{short_link.short_code}")
  end
end
