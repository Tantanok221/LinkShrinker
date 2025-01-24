class Analytics::GeographyComponent < ViewComponent::Base
  include Chartkick::Helper

  def initialize(country:, region:, city:)
    @country = country
    @region = region
    @city = city
  end

  private

  attr_reader :country, :region, :city
end