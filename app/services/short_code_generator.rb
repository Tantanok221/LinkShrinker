class ShortCodeGenerator
  def self.generate(logger: AppLogger.new("ShortCodeGenerator"), sequence_counter: SequenceCounter)
    timestamp = (Time.now.to_i * 1000) & 0xFFFFFFFF # 32 bits
    sequence = sequence_counter.next & 0xFFFF # 16 bits
    logger.info("seed: #{timestamp}, #{sequence}")
    # Combine timestamp and sequence
    id = (timestamp << 16) | sequence
    logger.info("id: #{id}")
    # Base62 encode and ensure 8 characters with leading zeros if needed
    id.base62_encode.rjust(8, "0")
  end
end
