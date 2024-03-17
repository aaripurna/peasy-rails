# frozen_string_literal: true

require 'temple'

module Eliquid
  class RailsTemplate # rubocop:disable Style/Documentation
    def self.call(template, source = nil)
      %|Eliquid::Renderer.new(#{template.source.inspect}).render(self, local_assigns)|
    end
  end
end
