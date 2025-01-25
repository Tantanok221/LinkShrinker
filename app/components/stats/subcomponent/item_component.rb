# frozen_string_literal: true

class Stats::Subcomponent::ItemComponent < ViewComponent::Base
  def initialize(date:, count:)
    @date = date
    @count = count
  end
end
