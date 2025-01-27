class ShortLinksController < ApplicationController
  def create
    respond_to do |format|
      @short_link = ShortLinkCreator.create(short_link_params,cookies.signed[:session_uuid])
      if @short_link
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
    ClickTracker.track_click(request, @short_link)
    redirect_to @short_link.target_url, allow_other_host: true
  end

  private

  def short_link_params
    params.require(:short_link).permit(:target_url)
  end
end