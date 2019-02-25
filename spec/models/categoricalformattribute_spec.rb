require 'rails_helper'

RSpec.describe Categoricalformattribute, :type => :model do

  it "should have many projects" do
    t = Categoricalformattribute.reflect_on_association(:formattributes)
    expect(t.macro).to eq(:belongs_to)
  end

end
