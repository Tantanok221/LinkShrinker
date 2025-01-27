class Analytic::AnalyticsComponent < ViewComponent::Base
  def initialize(analytics_data:)
    @analytics_data = analytics_data
  end

  private

  attr_reader :analytics_data

  delegate :short_link, :total_clicks, :time_data, :geo_data, :referrer_data, to: :analytics_data
end
