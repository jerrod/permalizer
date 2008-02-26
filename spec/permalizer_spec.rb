require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + "/../lib/permalizer.rb"

describe "permalizer" do
  
  before(:each) do
    String.class_eval { include Permalizer }
  end
  
  it "should create a simple permalink" do
    "testing one two three".permalize.should eql("testing-one-two-three")
  end
  
  it "should return a valid permalink with apostrophes" do
    "test's".permalize.should eql("tests")
    "I've been".permalize.should eql("ive-been")
  end
  
  it "should correctly handle single and double quotes" do
    "\'here are some single quotes\'".permalize.should eql("here-are-some-single-quotes")
    "\"and double quotes\"".permalize.should eql("and-double-quotes")
  end
  
  it "should correctly handle special characters" do
    "testing_underscores".permalize.should eql("testing-underscores")
    "more _ underscores".permalize.should eql("more-underscores")
    "unicode chåråcter".permalize.should eql("unicode-character")
    "colon: and : ; semicolon".permalize.should eql("colon-and-semicolon")
    "ampersand & here".permalize.should eql("ampersand-here")
    "explanation point!".permalize.should eql("explanation-point")
    "how are you?".permalize.should eql("how-are-you")
  end
  
  it "should handle various types of characters" do
    "several characters *& all ' together and () such".permalize.should eql("several-characters-all-together-and-such")
  end
  
  it "should keep dashes intact and handle multiple dashes" do
    "keep-this dash".permalize.should eql("keep-this-dash")
    "remove -- multiple---dashes".permalize.should eql("remove-multiple-dashes")
  end
  
  it "should correctly handle hyphens" do
    "here is a–hyphen".permalize.should eql("here-is-a-hyphen")
  end
  
  it "should return lower case characters" do
    "Should HanDle UPPER case LeTtErS".permalize.should eql("should-handle-upper-case-letters")
  end
  
end