require 'spec_helper'

describe DomFor::Model do

  context '#dom_for_model' do
    it 'returns empty div' do
      expect(helper.dom_for_model(User.new)).to eq '<div></div>'
    end

    it 'returns div without nested tags' do
      expect(helper.dom_for_model(User)).to eq '<div class="users" id="users" />'
    end

    it 'returns div with data-action attribute' do
      helper.request.stub(:path_parameters).and_return({ action: 'show' })

      expect(helper.dom_for_model(User)).to eq '<div class="users" data-action="show" id="users" />'
    end

    it 'returns div for the new user' do
      @user = User.new(name: 'test')
      helper.request.stub(:path_parameters).and_return({ action: 'new' })

      expect(helper.dom_for_model(User)).to eq '<div class="user new_user" data-action="new" id="new_user" />'
    end

    it 'returns div for the saved user' do
      @user = User.create(name: 'test')
      helper.request.stub(:path_parameters).and_return({ action: 'show' })

      expect(helper.dom_for_model(User)).to eq '<div class="user show_user" data-action="show" data-object-id="1" data-object="users" id="user_1" />'
    end

    it 'returns div with the additional data-attributes' do
      @user = User.create(name: 'test')
      helper.request.stub(:path_parameters).and_return({ action: 'show' })

      expect(helper.dom_for_model(User, admin: true)).to eq '<div class="user show_user" data-action="show" data-admin="true" data-object-id="1" data-object="users" id="user_1" />'
    end

    it 'returns div with nested tags' do
      @user = User.create(name: 'test')
      helper.request.stub(:path_parameters).and_return({ action: 'show' })

      expect(
        helper.dom_for_model(User, admin: true) { helper.tag(:span) }
      ).to eq '<div class="user show_user" data-action="show" data-admin="true" data-object-id="1" data-object="users" id="user_1"><span /></div>'
    end
  end

end