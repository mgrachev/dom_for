module DomFor
  #
  # Name of classes
  # Pages:
  #   index - users
  #   new   - user new_user
  #   edit  - user edit_user
  #   show  - user show_user
  #
  # ID name
  # Pages:
  #   index - users
  #   new   - new_user
  #   edit  - user_1
  #   show  - user_1
  #
  # Data-attributes
  # Pages:
  #   index - data-action = index
  #   new   - data-action = new
  #   edit  - data-action = edit, data-object-id = 1
  #   show  - data-action = show, data-object-id = 1
  #
  module Model
    #
    # Creates a div tag with the attributes for the model of ActiveRecord
    #
    # @example Without the block:
    #   dom_for(User) #=> <div class="users" id="users" />
    #
    # @example When there is a request:
    #   dom_for(User) #=> <div class="users" data-action="show" id="users" />
    #
    # @example For the new user:
    #   dom_for(User) #=> <div class="user new_user" data-action="new" id="new_user" />
    #
    # @example For the saved record (if exists @user):
    #   dom_for(User) #=> <div class="user show_user" data-action="show" data-object-id="1" data-object="users" id="user_1" />
    #
    # @example With the additional attributes:
    #   dom_for(User, admin: true) #=> <div class="user show_user" data-action="show" data-admin="true" data-object-id="1" data-object="users" id="user_1" />
    #
    # @example With the block:
    #   dom_for(User, admin: true) do
    #     tag(:span)
    #   end #=> <div class="user show_user" data-action="show" data-admin="true" data-object-id="1" data-object="users" id="user_1"><span /></div>
    #
    # @param klass [Class] Model of ActiveRecord::Base
    # @param tag [Symbol] HTML tag name
    # @param user_class [String] HTML class
    # @param attrs [Hash] Additional attributes for the record
    # @param block [Proc] Block for a div tag
    #
    # @return [String] Sanitized HTML string
    #
    def _dom_for_model(klass, tag, user_class, attrs = {}, &block)
      object_classes  = []
      class_name      = klass.to_s.underscore
      request_action  = request.path_parameters[:action]

      attrs.merge!(action: request_action) if request_action.present?

      object = instance_variable_get("@#{class_name}")

      # TODO: Need refactoring
      object_id = if object
                    if object.persisted?
                      attrs = attrs.merge(object_id: object.id, object: class_name.pluralize)
                    end

                    object_classes << dom_class(klass)
                    object_classes << dom_class(klass, request_action) if request_action.present?

                    dom_id(object)
                  else
                    object_classes << class_name.pluralize

                    class_name.pluralize
                  end

      html_class = object_classes.push(user_class).compact

      if block_given?
        content_tag(tag, id: object_id, class: html_class, data: attrs, &block)
      else
        tag(tag, id: object_id, class: html_class, data: attrs)
      end
    rescue
      content_tag(tag, &block)
    end

    private :_dom_for_model
  end
end
