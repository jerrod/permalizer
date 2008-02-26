require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + "/../lib/permalizer.rb"

describe "permalizer" do
  
  before(:each) do
    String.class_eval { include Permalizer }
  end
  
  it "should create a simple permalink" do
    "testing one two three".permalize.should eql("testing-one-two-three")
  end
  
end