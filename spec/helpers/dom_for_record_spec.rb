require 'rails_helper'

describe DomFor::Record do

  context '#dom_for_record' do
    it 'returns empty div' do
      expect(helper.dom_for_record(User)).to eq '<div></div>'
    end

    it 'returns div for the new user' do
      expect(helper.dom_for_record(User.new)).to eq '<div id="new_user" class="user" />'
    end

    it 'returns div without nested tags' do
      user = User.create(name: 'test')

      expect(helper.dom_for_record(user)).to eq '<div id="user_1" class="user" data-object-id="1" />'
    end

    it 'returns div with nested tags' do
      user = User.create(name: 'test')

      expect(
        helper.dom_for_record(user) { helper.tag(:span) }
      ).to eq '<div id="user_1" class="user" data-object-id="1"><span /></div>'
    end

    it 'returns div with the additional data-attributes' do
      user = User.create(name: 'test')

      expect(
          helper.dom_for_record(user, admin: true) { helper.tag(:span) }
      ).to eq '<div id="user_1" class="user" data-admin="true" data-object-id="1"><span /></div>'
    end
  end

end
