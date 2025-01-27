# frozen_string_literal: true

class Forms::ShrinkLinkResultComponent < ViewComponent::Base
  def initialize(redirect_link:, short_code:, target_url:)
    @redirect_link = redirect_link
    @short_code = short_code
    @target_url = target_url
  end
end
