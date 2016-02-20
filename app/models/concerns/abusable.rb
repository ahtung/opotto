# Abusable
module Abusable
  extend ActiveSupport::Concern

  included do
    has_many :reported_abuses, class_name: 'Abuse', as: :resource do
      def confirmed
        find(:all, conditions: ["confirmed = ?", true])
      end

      def pending
        find(:all, conditions: ["confirmed = ?", false])
      end
    end
  end

  def is_an_abuse?
    !self.reported_abuses.confirmed.blank?
  end
end
