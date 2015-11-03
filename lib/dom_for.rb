require 'active_support/dependencies/autoload'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/string/inflections'

module DomFor
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
  extend ActiveSupport::Autoload

  autoload :Model
  autoload :Record

  include Model
  include Record

  #
  # Creates a div tag with the attributes for the model or record of ActiveRecord
  #
  # @param [ActiveRecord::Base, Class] object Model or record of ActiveRecord
  # @param [Hash] attrs Additional attributes for the record
  # @param [Proc] block Block for a div tag
  #
  # @return [String] Sanitized HTML string
  #
  def dom_for(object, attrs = {}, &block)
    if object.instance_of? Class
      dom_for_model(object, attrs, &block)
    else
      dom_for_record(object, attrs, &block)
    end
  end
end

require_relative 'dom_for/railtie' if defined? Rails
