require 'liquid'

module Eliquid
  class Renderer
    def initialize(str)
      @str = str
    end

    def render(template, locals)
      filter = Module.new do
        include Rails.application.helpers
      end

      assigns = Assigns.new(template)

      Liquid::Template.parse(@str).render(assigns.merge_assigns(locals), filters: [filter])
    end
  end
end