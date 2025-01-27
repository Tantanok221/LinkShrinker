class Analytic::Subcomponent::ReferrerComponent < ViewComponent::Base
  def initialize(data:)
    @data = data
  end

  private

  attr_reader :data
end