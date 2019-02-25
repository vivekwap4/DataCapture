require 'spec_helper'
require 'rails_helper'

describe TutorialpageController do
  describe 'renders index template page' do
    it 'should render index template' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
