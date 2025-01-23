# frozen_string_literal: true

class Card::ShrinkLinkResultComponent < ViewComponent::Base
  def initialize(link:)
    @link = link
  end
end
