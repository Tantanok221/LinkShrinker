class Forms::LinkSubmitComponent < ViewComponent::Base
  attr_reader :short_link

  def initialize(short_link:)
    @short_link = short_link
  end
end
