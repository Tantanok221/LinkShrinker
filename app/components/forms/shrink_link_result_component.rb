# frozen_string_literal: true

class Forms::ShrinkLinkResultComponent < ViewComponent::Base
  def initialize(redirect_link:, short_code:, target_url:, title:)
    @redirect_link = redirect_link
    @short_code = short_code
    @target_url = target_url
    @title = title
  end
end
