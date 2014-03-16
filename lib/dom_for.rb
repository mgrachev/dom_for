require 'dom_for/record'

module DomFor
  include Record
end

ActionView::Helpers.send(:include, DomFor)