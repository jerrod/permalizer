
# Permalizer adds functionality to the String Object so that clean URLs creation is made simple
module Permalink
  module InstanceMethods
    # permalize! is a destructive method that will make the given string for use as a clean URL
    # example:
    # blog.title = "My Cool Gem!"
    # blog.title.permalize! # => "my-cool-gem"
    #
    def permalize!
      replace Permalink::Permalizer.new(self).to_s
    end

    # permalize is the same as permalize! except that it is not a destructive method
    # it creates a duplicate of the string and returns it as a clean string for URL usage
    #
    def permalize
      Permalink::Permalizer.new(self).to_s
    end
  end
  
  class Permalizer
    
    
    # This allow to set Permalink::Permalizer.decompose_string = true in a initializer hook
    class << self
      attr_accessor :decompose_string
    end
    
    def initialize(word)
      # only if decompose_string is true and ActiveSupport is loaed in UTF-8 mode (with UTF8Handler as handler class)
      # This is required for some remote Linux machines, I regulary use it in production environment
      @word = (Permalizer.decompose_string && word.respond_to?(:chars) && word.chars.respond_to?(:decompose))? word.chars.decompose : word
    end
    
    # permalink
    # Fix unicode characters, regex unwanted characters, split string, thus removing all whitespace, join it, and downcase it                   
    #
    # TODO: Ruby 1.9 string encoding
    def to_s
      (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv @word).gsub(/[^\w\s\-\—]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase
    end
  end
end
