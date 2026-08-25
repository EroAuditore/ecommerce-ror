module Auditable
  extend ActiveSupport::Concern

  included do
    belongs_to :created_by, class_name: "User", optional: true
    belongs_to :updated_by, class_name: "User", optional: true

    before_create :set_created_by
    before_save :set_updated_by
  end

  private

  def set_created_by
    self.created_by = Current.user if Current.user
  end

  def set_updated_by
    self.updated_by = Current.user if Current.user
  end
end
