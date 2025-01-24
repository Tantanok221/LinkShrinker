# frozen_string_literal: true

class Analytic::HeaderComponent < ViewComponent::Base
  include Chartkick::Helper

  def initialize(short_link:,total_clicks:)
    @short_link = short_link
    @total_clicks = total_clicks
  end

  private

  attr_reader :short_link, :total_clicks
end
