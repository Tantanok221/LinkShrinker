# frozen_string_literal: true

class Stats::TimePeriodListComponent < ViewComponent::Base
  def initialize(title:, period_label:, data:)
    @title = title
    @period_label = period_label
    @data = validate_data(data)
    super
  end

  private

  def validate_data(data)
    raise ArgumentError, "Data must be a hash" unless data.is_a?(Hash)
    data
  end
end
