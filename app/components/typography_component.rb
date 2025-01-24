# frozen_string_literal: true

class TypographyComponent < ViewComponent::Base
  def initialize(variant: :h1)
    @variant = variant
    @classes = case variant
               when :h1 then "text-3xl font-semibold font-sans"
               when :h2 then "text-1xl w-full h-full font-semibold font-sans"
    end
  end
end
