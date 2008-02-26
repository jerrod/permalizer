require 'lib/permalizer'
# mixin Permalizer in the String Object Class
String.class_eval do
  include Permalizer
end