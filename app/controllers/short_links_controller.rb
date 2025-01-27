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
    ClickTracker.new(request: request, model: Click).track_click(@short_link)
    redirect_to @short_link.target_url, allow_other_host: true
  end

  private

  def short_link_params
    params.require(:short_link).permit(:target_url)
  end
end