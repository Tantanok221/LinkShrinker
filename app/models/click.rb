class Click < ApplicationRecord
  belongs_to :short_link
  after_create_commit :broadcast_analytics_update

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
end
