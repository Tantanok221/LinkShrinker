# frozen_string_literal: true

class Stats::Subcomponent::ListComponent < ViewComponent::Base
  def initialize(data:,period_label:)
    @data = data
    @period_label = period_label
  end
end
