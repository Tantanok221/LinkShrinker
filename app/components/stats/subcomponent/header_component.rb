# frozen_string_literal: true

class Stats::Subcomponent::HeaderComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
