require 'rails_helper'

describe DomFor do

  it 'includes in ActiveView::Base' do
    expect(ActionView::Base.ancestors).to include(DomFor)
    expect(ActionView::Base.ancestors).to include(DomFor::Model)
    expect(ActionView::Base.ancestors).to include(DomFor::Record)
  end

  context '#dom_for' do
    it 'invokes #dom_for_model' do
      expect(helper.dom_for(User)).to eq '<div id="users" class="users" />'
    end

    it 'invokes #dom_for_record' do
      expect(helper.dom_for(User.new)).to eq '<div id="new_user" class="user" />'
    end
  end

end
