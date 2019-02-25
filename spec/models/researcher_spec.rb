require 'rails_helper'

RSpec.describe Researcher, :type => :model do
  it "cannot create new researcher without authentication id " do
    expect(Researcher.create(:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'test')).to_not be_valid
  end

  it "create new researcher" do
    expect(Researcher.create(:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'test', :authentications_id => '1')).to be_valid
    researcher = {:firstname => 'nabeel', :lastname => 'khan', :researchgroup => 'test', :authentications_id => '1'}
    expect(Researcher.create_researcher(researcher)).to be_valid
  end

  it "should have many projects" do
    t = Researcher.reflect_on_association(:projects)
    expect(t.macro).to eq(:has_many)
  end
end
