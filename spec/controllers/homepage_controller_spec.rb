require 'spec_helper'
require 'rails_helper'

describe HomepageController do
  describe 'renders index template page' do
    it 'should render index template' do
      get :index
      expect(response).to redirect_to('/login')
    end
  end
end
