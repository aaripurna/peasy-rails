require 'liquid'

module Eliquid
  class Renderer
    def initialize(str)
      @str = str
    end

    def render(template, locals)
      assigns = Assigns.new(template)

      Liquid::Template.parse(@str).render(assigns.merge_assigns(locals), filters: [Rails.application.helpers, Rails.application.routes.url_helpers])
    end
  end
end