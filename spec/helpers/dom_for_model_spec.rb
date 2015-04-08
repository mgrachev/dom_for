require 'rails_helper'

describe DomFor::Model do

  context '#dom_for_model' do
    it 'returns empty div' do
      expect(helper.dom_for_model(User.new)).to eq '<div></div>'
    end

    it 'returns div without nested tags' do
      expect(helper.dom_for_model(User)).to eq '<div id="users" class="users" />'
    end

    it 'returns div with data-action attribute' do
      expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

      expect(helper.dom_for_model(User)).to eq '<div id="users" class="users" data-action="show" />'
    end

    it 'returns div for the new user' do
      @user = User.new(name: 'test')
      expect(helper.request).to receive(:path_parameters).and_return({ action: 'new' })

      expect(helper.dom_for_model(User)).to eq '<div id="new_user" class="user new_user" data-action="new" />'
    end

    it 'returns div for the new user without request' do
      @user = User.new(name: 'test')

      expect(helper.dom_for_model(User)).to eq '<div id="new_user" class="user" />'
    end

    it 'returns div for the saved user' do
      @user = User.create(name: 'test')
      expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

      expect(helper.dom_for_model(User)).to eq '<div id="user_1" class="user show_user" data-action="show" data-object-id="1" data-object="users" />'
    end

    it 'returns div with the additional data-attributes' do
      @user = User.create(name: 'test')
      expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

      expect(helper.dom_for_model(User, admin: true)).to eq '<div id="user_1" class="user show_user" data-admin="true" data-action="show" data-object-id="1" data-object="users" />'
    end

    it 'returns div with nested tags' do
      @user = User.create(name: 'test')
      expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

      expect(
        helper.dom_for_model(User, admin: true) { helper.tag(:span) }
      ).to eq '<div id="user_1" class="user show_user" data-admin="true" data-action="show" data-object-id="1" data-object="users"><span /></div>'
    end
  end

end
