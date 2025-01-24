# frozen_string_literal: true

class Forms::ShrinkLinkResultComponent < ViewComponent::Base
  def initialize(link:)
    @link = link
  end
end
