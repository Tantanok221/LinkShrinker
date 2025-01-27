class ShortLinksController < ApplicationController
  def create
    @short_link = ShortLink.new(short_link_params)
    @short_link.user_id = cookies.signed[:session_uuid]
    respond_to do |format|
      if @short_link.save
        format.turbo_stream
      else
        Rails.logger.error "Something went wrong!"
        format.turbo_stream do
          render :error, locals: { message: "Save to database operation went wrong, please contact website administrator!" }
        end
      end
    end
  end

  def show
    @short_link = ShortLink.find(params[:id])
  end

  def delete
    @short_link = ShortLink.find(params[:id])
  end

  def redirect
    @short_link = ShortLink.find_by(short_code: params[:short_code])
    @short_link.increment!(:clicks_count)
    ip_address = request.remote_ip
    Rails.logger.info request.remote_ip
    location = Geocoder.search(ip_address).first

    Click.create!(short_link: @short_link,
                  ip_address: request.remote_ip,
                  user_agent: request.user_agent,
                  referrer: request.referrer,
                  country: location.country,
                  region: location.region,
                  city: location.city,
                  created_at: Time.now,
                  updated_at: Time.now,)
    redirect_to @short_link.target_url, allow_other_host: true
  end

  private

  def short_link_params
    params.require(:short_link).permit(:target_url)
  end
end