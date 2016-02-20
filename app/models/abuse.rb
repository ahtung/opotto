class Abuse < ActiveRecord::Base
  belongs_to :resource, polymorphic: true

  def confirm!
    self.confirmed = true
    save unless new_record?
  end
end
