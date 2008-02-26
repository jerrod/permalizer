require File.dirname(__FILE__) + '/spec_helper'
MERB_PERMALIZER_ROOT = File.dirname(__FILE__) + "/.."
# same structure as merb_helpers

describe "permalizer" do
  
  def unload_permalizer
    Merb.class_eval do
      remove_const("Permalizer") if defined?(Merb::Permalizer)
    end
  end
  
  def reload_permalizer
    unload_permalizer
    load(MERB_PERMALIZER_ROOT + "/lib/permalizer.rb")
  end
  
  before(:each) do
    unload_permalizer
  end
  
  after(:all) do
    reload_permalizer
  end
  
  it "should not have permalizer" do
    unload_permalizer
    defined?(Merb::Permalizer).should be_nil
  end
  
  it "should load permalizer" do
    unload_permalizer
    reload_permalizer
    defined?(Merb::Permalizer).should_not be_nil
  end
  
  it "should load permalizer by default" do
    reload_permalizer
    defined?(Merb::Permalizer).should_not be_nil
  end
  
end