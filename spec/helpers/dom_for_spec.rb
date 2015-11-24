require 'rails_helper'

describe DomFor do
  it 'includes in ActiveView::Base' do
    expect(ActionView::Base.ancestors).to include(DomFor)
  end

  context '#dom_for' do
    it 'returns span tag' do
      expect(helper.dom_for(User, tag: :span)).to eq '<span id="users" class="users" />'
    end

    it 'returns div with html class' do
      expect(helper.dom_for(User, class: 'test ruby')).to eq '<div id="users" class="users test ruby" />'
    end

    context 'with model' do
      it 'returns div without nested tags' do
        expect(helper.dom_for(User)).to eq '<div id="users" class="users" />'
      end

      it 'returns div with data-action attribute' do
        expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

        expect(helper.dom_for(User)).to eq '<div id="users" class="users" data-action="show" />'
      end

      it 'returns div for the new user' do
        @user = User.new(name: 'test')
        expect(helper.request).to receive(:path_parameters).and_return({ action: 'new' })

        expect(helper.dom_for(User)).to eq '<div id="new_user" class="user new_user" data-action="new" />'
      end

      it 'returns div for the new user without request' do
        @user = User.new(name: 'test')

        expect(helper.dom_for(User)).to eq '<div id="new_user" class="user" />'
      end

      it 'returns div for the saved user' do
        @user = User.create(name: 'test')
        expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

        expect(
          helper.dom_for(User)
        ).to eq '<div id="user_1" class="user show_user" data-action="show" data-object-id="1" data-object="users" />'
      end

      it 'returns div with the additional data-attributes' do
        @user = User.create(name: 'test')
        expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

        expect(
          helper.dom_for(User, admin: true)
        ).to eq '<div id="user_1" class="user show_user" data-admin="true" data-action="show" data-object-id="1" data-object="users" />'
      end

      it 'returns div with nested tags' do
        @user = User.create(name: 'test')
        expect(helper.request).to receive(:path_parameters).and_return({ action: 'show' })

        expect(
          helper.dom_for(User, admin: true) { helper.tag(:span) }
        ).to eq '<div id="user_1" class="user show_user" data-admin="true" data-action="show" data-object-id="1" data-object="users"><span /></div>'
      end
    end

    context 'with record' do
      it 'returns div for the new user' do
        expect(helper.dom_for(User.new)).to eq '<div id="new_user" class="user" />'
      end

      it 'returns div without nested tags' do
        user = User.create(name: 'test')

        expect(helper.dom_for(user)).to eq '<div id="user_1" class="user" data-object-id="1" />'
      end

      it 'returns div with nested tags' do
        user = User.create(name: 'test')

        expect(
          helper.dom_for(user) { helper.tag(:span) }
        ).to eq '<div id="user_1" class="user" data-object-id="1"><span /></div>'
      end

      it 'returns div with the additional data-attributes' do
        user = User.create(name: 'test')

        expect(
            helper.dom_for(user, admin: true) { helper.tag(:span) }
        ).to eq '<div id="user_1" class="user" data-admin="true" data-object-id="1"><span /></div>'
      end
    end
  end
end
