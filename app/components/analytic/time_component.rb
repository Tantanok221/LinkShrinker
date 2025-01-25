class Analytic::TimeComponent < ViewComponent::Base

  def initialize(daily:, weekly:, monthly:)
    @daily = daily
    @weekly = weekly
    @monthly = monthly
  end

  private

  attr_reader :daily, :weekly, :monthly
end