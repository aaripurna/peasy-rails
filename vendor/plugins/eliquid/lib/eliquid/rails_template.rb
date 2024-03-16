# frozen_string_literal: true

require 'temple'

module Eliquid
  class RailsTemplate < Temple::Templates::Rails # rubocop:disable Style/Documentation
    def self.call(template, source = nil)
      options.update(engine: Engine)

      str = new.call(template, source)
      %|Eliquid::Renderer.new("#{str}").render(self, local_assigns)|
    end
  end
end
