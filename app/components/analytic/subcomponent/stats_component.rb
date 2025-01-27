class Analytic::Subcomponent::StatsComponent < ViewComponent::Base
  def initialize(title:, stats:)
    @title = title
    @stats = stats
  end
end
