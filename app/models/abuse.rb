# Abuse model
class Abuse < ActiveRecord::Base
  # Relations
  belongs_to :resource, polymorphic: true

  # Scopes
  scope :pending, -> { where(confirmed: false) }
  scope :confirmed, -> { where(confirmed: true) }

  # Instance methods
  def confirm!
    self.confirmed = true
    save unless new_record?
  end
end
