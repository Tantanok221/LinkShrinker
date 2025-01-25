class Analytic::GeographyComponent < ViewComponent::Base

  def initialize(country:, region:, city:)
    @country = country
    @region = region
    @city = city
  end

  private

  attr_reader :country, :region, :city
end