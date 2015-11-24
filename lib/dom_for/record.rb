module DomFor
  #
  # Class name: user
  #
  # ID name: user_1
  #
  # Data-attributes: data-object-id = 1
  #
  module Record
    #
    # Creates a div tag with the attributes for the instance of ActiveRecord
    #
    # @example For the new record:
    #   dom_for(User.new) #=> <div class="user" id="new_user" />
    #
    # @example For the saved record:
    #   dom_for(@user) #=> <div class="user" data-object-id="1" id="user_1" />
    #
    # @example With the additional attributes:
    #   dom_for(@user, admin: true) #=> <div class="user" data-admin="true" data-object-id="1" id="user_1" />
    #
    # @example With the block:
    #   dom_for(@user, admin: true) do
    #     tag(:span)
    #   end #=> <div class="user" data-admin="true" data-object-id="1" id="user_1"><span /></div>
    #
    # @param record [ActiveRecord::Base] Instance of ActiveRecord::Base
    # @param tag [Symbol] HTML tag name
    # @param attrs [Hash] Additional attributes for the record
    # @param block [Proc] Block for a div tag
    #
    # @return [String] Sanitized HTML string
    #
    def _dom_for_record(record, tag, attrs = {}, &block)
      object_id     = dom_id(record)
      object_class  = dom_class(record.class)

      attrs = attrs.merge(object_id: record.id) if record.persisted?

      if block_given?
        content_tag(tag, id: object_id, class: object_class, data: attrs, &block)
      else
        tag(tag, id: object_id, class: object_class, data: attrs)
      end
    rescue
      content_tag(tag, &block)
    end

    private :_dom_for_record
  end
end
