class ShortLinkCreator
  def self.save(short_link_params:, user_id:, model: ShortLink, logger: AppLogger.new("ShortLinkCreator"))
    new(short_link_params, user_id, model: model, logger: logger).save
  end

  def initialize(short_link_params, user_id, model: ShortLink, logger: AppLogger)
    @short_link = model.new(short_link_params)
    @short_link.user_id = user_id
    @short_link.clicks_count = 0
    @logger = logger
  end

  def save
    if @short_link.save
      @short_link
    else
      logger.error("Database Operation Gone Wrong!")
      false
    end
  end
end