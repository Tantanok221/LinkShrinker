# frozen_string_literal: true

class Forms::ShrinkLinkResultComponent < ViewComponent::Base
  def initialize(link:,short_code:)
    @link = link
    @short_code = short_code
  end
end
