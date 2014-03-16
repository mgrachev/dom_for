module DomFor
  module Record
    # Creates a div tag with the attributes for record
    #
    # @param [ActiveRecord::Base] record Instance of ActiveRecord::Base
    # @param [Hash] attrs Additional attributes for the record
    # @param [Proc] block Block for a div tag
    #
    # @return [String] Sanitized HTML string
    #
    # @example For the new record:
    #   dom_for_record(User.new) #=> <div class="user" id="new_user" />
    #
    # @example For the saved record:
    #   dom_for_record(@user) #=> <div class="user" data-object-id="1" id="user_1" />
    #
    # @example With the additional attributes:
    #   dom_for_record(@user, admin: true) #=> <div class="user" data-admin="true" data-object-id="1" id="user_1" />
    #
    # @example With the block:
    #   dom_for_record(@user, admin: true) do
    #     tag(:span)
    #   end #=> <div class="user" data-admin="true" data-object-id="1" id="user_1"><span /></div>
    #
    def dom_for_record(record, attrs={}, &block)
      object_id     = dom_id(record)
      object_class  = dom_class(record.class)

      attrs = attrs.merge(object_id: record.id) if record.persisted?

      if block_given?
        content_tag(:div, id: object_id, class: object_class, data: attrs, &block)
      else
        tag(:div, id: object_id, class: object_class, data: attrs)
      end

    rescue
      content_tag(:div, &block)
    end
  end
end