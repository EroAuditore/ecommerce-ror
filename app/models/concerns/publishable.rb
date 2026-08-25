module Publishable
  extend ActiveSupport::Concern

  included do
    scope :published, -> { where.not(published_at: nil).where("published_at <= ?", Time.current) }
    scope :draft, -> { where(published_at: nil) }
  end

  def publish!
    update!(published_at: Time.current)
  end

  def unpublish!
    update!(published_at: nil)
  end

  def published?
    published_at.present? && published_at <= Time.current
  end
end
