# Abusable
module Abusable
  extend ActiveSupport::Concern

  included do
    has_many :reported_abuses, class_name: 'Abuse', as: :resource
  end

  def abuse?
    !reported_abuses.confirmed.blank?
  end
end
