# frozen_string_literal: true

class TypographyComponent < ViewComponent::Base
  def initialize(variant: :h1, classes: "")
    @variant = variant
    @class = classes
    @classes = case variant
    when :h1 then "text-3xl font-semibold font-sans"
    when :h2 then "text-lg font-medium font-sans"
    when :h3 then "text-xl font-medium font-sans"
    end
  end
end
