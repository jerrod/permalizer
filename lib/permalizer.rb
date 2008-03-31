# required for handling unicode/various languages
require 'iconv'

# permalizer files
require 'lib/permalizer/permalink.rb'

# open the String Class and include our additions
String.class_eval do
  include Permalink
end