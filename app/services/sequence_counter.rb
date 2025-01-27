module SequenceCounter
  CACHE_KEY = "sequence_counter".freeze

  def self.next
    Rails.cache.fetch(CACHE_KEY) { 0 }
    Rails.cache.increment(CACHE_KEY)
  end

  def self.get
    Rails.cache.fetch(CACHE_KEY) { 0 }
  end
end
