module DomFor
  module Model
    # Creates a div tag with the attributes for the model
    #
    # @example Without the block:
    #   dom_for_model(User) #=> <div class="users" id="users" />
    #
    # @example When there is a request:
    #   dom_for_model(User) #=> <div class="users" data-action="show" id="users" />
    #
    # @example For the new user:
    #   dom_for_model(User) #=> <div class="user new_user" data-action="new" id="new_user" />
    #
    # @example For the saved record (if exists @user):
    #   dom_for_model(User) #=> <div class="user show_user" data-action="show" data-object-id="1" data-object="users" id="user_1" />
    #
    # @example With the additional attributes:
    #   dom_for_model(User, admin: true) #=> <div class="user show_user" data-action="show" data-admin="true" data-object-id="1" data-object="users" id="user_1" />
    #
    # @example With the block:
    #   dom_for_model(User, admin: true) do
    #     tag(:span)
    #   end #=> <div class="user show_user" data-action="show" data-admin="true" data-object-id="1" data-object="users" id="user_1"><span /></div>
    #
    # @param [Class] klass Model of ActiveRecord::Base
    # @param [Hash] attrs Additional attributes for the record
    # @param [Proc] block Block for a div tag
    #
    # @return [String] Sanitized HTML string
    def dom_for_model(klass, attrs={}, &block)
      object_classes  = []
      class_name      = klass.to_s.underscore
      request_action  = request.path_parameters[:action]

      attrs.merge!(action: request_action) if request_action.present?

      object = instance_variable_get("@#{class_name}")

      object_id = if object
                    if object.persisted?
                      attrs = attrs.merge(object_id: object.id, object: class_name.pluralize)
                    end

                    object_classes << dom_class(klass)
                    object_classes << dom_class(klass, request_action)

                    dom_id(object)
                  else
                    object_classes << class_name.pluralize

                    class_name.pluralize
                  end

      if block_given?
        content_tag(:div, id: object_id, class: object_classes.join(' '), data: attrs, &block)
      else
        tag(:div, id: object_id, class: object_classes.join(' '), data: attrs)
      end

    rescue
      content_tag(:div, &block)
    end
  end
end