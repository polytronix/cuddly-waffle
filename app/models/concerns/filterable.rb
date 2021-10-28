require 'active_support/concern'

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(params)
      self.all { |filtered, (k, v)| v.present? ? filtered.public_send(k, v) : filtered }
    end
  end
end
 