# frozen_string_literal: true

class Card::StatsComponent < ViewComponent::Base
  def initialize(title:,number:)
    @title = title
    @number = number
  end
end
