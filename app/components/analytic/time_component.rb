class Analytics::TimeAnalysisComponent < ViewComponent::Base
  include Chartkick::Helper

  def initialize(daily:, weekly:, monthly:)
    @daily = daily
    @weekly = weekly
    @monthly = monthly
  end

  private

  attr_reader :daily, :weekly, :monthly
end