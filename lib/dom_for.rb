require 'active_support/dependencies/autoload'

module DomFor
  extend ActiveSupport::Autoload

  autoload :Model
  autoload :Record
end

ActionView::Helpers.send(:include, DomFor)