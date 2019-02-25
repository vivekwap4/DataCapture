require 'rails_helper'

RSpec.describe Dataentry, :type => :model do
  it "cannot create new dataentry without authentication id " do
    expect(Dataentry.create(:firstname => 'nabeel', :lastname => 'khan', :profile => 'test', :institution => 'test')).to_not be_valid
  end

  it "create new dataentry" do
    expect(Dataentry.create(:firstname => 'nabeel', :lastname => 'khan', :profile => 'test', :institution => 'test', :authentications_id => '1')).to be_valid
    dataentry = {:firstname => 'nabeel', :lastname => 'khan', :profile => 'test', :institution => 'test', :authentications_id => '1'}
    expect(Dataentry.create_dataentry(dataentry)).to be_valid
  end

  it "should have many projects" do
    t = Dataentry.reflect_on_association(:forms)
    expect(t.macro).to eq(:has_many)
  end
end
