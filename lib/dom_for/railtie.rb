module DomFor
  class Railtie < ::Rails::Railtie
    initializer 'dom_for.initialize' do
      ActiveSupport.on_load(:action_view) do
        ActionView::Base.send(:include, DomFor)
      end
    end
  end
end
