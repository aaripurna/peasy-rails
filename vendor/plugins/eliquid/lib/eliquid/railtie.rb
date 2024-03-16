module Eliquid
  class Railtie < ::Rails::Railtie
    initializer 'initialize liquid template handler' do |app|
      ActiveSupport.on_load(:action_view) do
        ::ActionView::Template.register_template_handler :liquid, RailsTemplate
      end
    end
  end
end
