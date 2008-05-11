require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + "/../lib/permalizer.rb"

describe "permalizer" do
  
  it "should create a simple permalink" do
    "testing one two three".permalize.should eql("testing-one-two-three")
    "testing one two bang".permalize!.should eql("testing-one-two-bang")
  end
  
  it "should return a valid permalink with apostrophes" do
    "test's".permalize.should eql("tests")
    "test's".permalize!.should eql("tests")
    
    "I've been".permalize.should eql("ive-been")
    "I've been banged".permalize!.should eql("ive-been-banged")
  end
  
  it "should ovewrite string original value when permalize! is called" do
    string = "i'll be overriden soon"
    string.permalize!
    string.should eql("ill-be-overriden-soon")
  end
  
  it "should correctly handle single and double quotes" do
    "\'here are some single quotes\'".permalize.should eql("here-are-some-single-quotes")
    "\'here are some single quotes\'".permalize!.should eql("here-are-some-single-quotes")
    
    "\"and double quotes\"".permalize.should eql("and-double-quotes")
    "\"and double quotes\"".permalize!.should eql("and-double-quotes")
  end
  
  it "should correctly handle special characters" do
    "testing_underscores".permalize.should eql("testing-underscores")
    "testing_underscores".permalize!.should eql("testing-underscores")
    
    "more _ underscores".permalize.should eql("more-underscores")
    "more _ underscores".permalize!.should eql("more-underscores")
    
    "unicode chåråcter".permalize.should eql("unicode-character")
    "unicode chåråcter".permalize!.should eql("unicode-character")
    
    "colon: and : ; semicolon".permalize.should eql("colon-and-semicolon")
    "colon: and : ; semicolon".permalize!.should eql("colon-and-semicolon")
    
    "ampersand & here".permalize.should eql("ampersand-here")
    "ampersand & here".permalize!.should eql("ampersand-here")
    
    "explanation point!".permalize.should eql("explanation-point")
    "explanation point!".permalize!.should eql("explanation-point")
    
    "how are you?".permalize.should eql("how-are-you")
    "how are you?".permalize!.should eql("how-are-you")
  end
  
  it "should handle various types of characters" do
    "several characters *& all ' together and () such".permalize.should eql("several-characters-all-together-and-such")
    
    "several characters *& all ' together and () such".permalize!.should eql("several-characters-all-together-and-such")
  end
  
  it "should keep dashes intact and handle multiple dashes" do
    "keep-this dash".permalize.should eql("keep-this-dash")
    "keep-this dash".permalize!.should eql("keep-this-dash")
    
    "remove -- multiple---dashes".permalize.should eql("remove-multiple-dashes")
    "remove -- multiple---dashes".permalize!.should eql("remove-multiple-dashes")
    
  end
  
  it "should correctly handle hyphens" do
    "here is a–hyphen test–this".permalize.should eql("here-is-a-hyphen-test-this")
    "here is a–hyphen".permalize!.should eql("here-is-a-hyphen")
  end
  
  it "should return lower case characters" do
    "Should HanDle UPPER case LeTtErS".permalize.should eql("should-handle-upper-case-letters")
    
    "Should HanDle UPPER case LeTtErS".permalize!.should eql("should-handle-upper-case-letters")
  end
  
  it "should perform permalization even with a misspelled fix_method" do
    Permalink::Permalizer.translate_to = :undefined_fix_method
    "This will be permalized".permalize.should eql("this-will-be-permalized")
  end
  
  it "should perform an utf-8 transformation" do
    Permalink::Permalizer.translate_to = :utf_8
    "This string contains utf-8 characters: esdrújula. €100".permalize.should eql("this-string-contains-utf-8-characters-esdrujula-eur100")
  end
end