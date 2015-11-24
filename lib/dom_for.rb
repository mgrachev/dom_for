require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

require_relative 'dom_for/model'
require_relative 'dom_for/record'

module DomFor
  include Model
  include Record
  #
  # dom_for Project do
  #
  #   dom_for Task do
  #     dom_for task, attribute: 'yes'
  #
  #   dom_for User do
  #     dom_for user, admin: false
  #
  #   dom_for Comment do
  #     dom_for comment, private: true
  #
  # Creates a html tag with the attributes for the model or record of ActiveRecord
  #
  # @param object [ActiveRecord::Base, Class] Model or record of ActiveRecord
  # @param attrs [Hash] Additional attributes for the record
  # @param block [Proc] Block for a div tag
  #
  # @return [String] Sanitized HTML string
  #
  def dom_for(object, attrs = {}, &block)
    tag   = attrs.delete(:tag) || :div
    klass = attrs.delete(:class)

    if object.instance_of? Class
      _dom_for_model(object, tag, klass, attrs, &block)
    else
      _dom_for_record(object, tag, klass, attrs, &block)
    end
  end
end

require_relative 'dom_for/railtie' if defined? ::Rails
