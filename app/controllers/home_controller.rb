class HomeController < ApplicationController
  before_action :set_session_uuid

  def index
    @short_link = ShortLink.new
    @counts = SequenceCounter.get
  end

  def set_session_uuid
    cookies.permanent.signed[:session_uuid] ||= SecureRandom.uuid
  end
end
