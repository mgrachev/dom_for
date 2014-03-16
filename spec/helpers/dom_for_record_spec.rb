require 'spec_helper'

describe DomFor::Record do

  context '#dom_for_record' do
    it 'returns empty div' do
      expect(helper.dom_for_record(User)).to eq '<div></div>'
    end

    it 'returns div for the new user' do
      expect(helper.dom_for_record(User.new)).to eq '<div class="user" id="new_user" />'
    end

    it 'returns div without nested tags' do
      user = User.create(name: 'test')
      expect(helper.dom_for_record(user)).to eq '<div class="user" data-object-id="1" id="user_1" />'
    end

    it 'returns div with nested tags' do
      user = User.create(name: 'test')
      expect(
        helper.dom_for_record(user) { helper.tag(:span) }
      ).to eq '<div class="user" data-object-id="1" id="user_1"><span /></div>'
    end

    it 'returns div with the additional data-attributes' do
      user = User.create(name: 'test')
      expect(
          helper.dom_for_record(user, admin: true) { helper.tag(:span) }
      ).to eq '<div class="user" data-admin="true" data-object-id="1" id="user_1"><span /></div>'
    end
  end

end