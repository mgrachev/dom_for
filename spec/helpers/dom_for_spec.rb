require 'spec_helper'

describe DomFor do

  context '#dom_for' do
    it 'invokes #dom_for_model' do
      expect(helper.dom_for(User)).to eq '<div class="users" id="users" />'
    end

    it 'invokes #dom_for_record' do
      expect(helper.dom_for(User.new)).to eq '<div class="user" id="new_user" />'
    end
  end

end