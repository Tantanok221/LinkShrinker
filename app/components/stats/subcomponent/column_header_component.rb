# frozen_string_literal: true

class Stats::Subcomponent::ColumnHeaderComponent < ViewComponent::Base
  def initialize(period_label:)
    @period_label = period_label
  end
end
