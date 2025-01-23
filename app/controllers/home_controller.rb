class HomeController < ApplicationController
  def index
    @short_link = ShortLink.new
  end
end