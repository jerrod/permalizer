
# Permalizer adds functionality to the String Object so that clean URLs creation is made simple
module Permalink
  module InstanceMethods
    
    # permalize! is a destructive method that will make the given string for use as a clean URL
    # example:
    # blog.title = "My Cool Gem!"
    # blog.title.permalize! # => "my-cool-gem"
    #
    def permalize!
      replace permalize
    end

    # permalize is the same as permalize! except that it is not a destructive method
    # it creates a duplicate of the string and returns it as a clean string for URL usage
    #
    def permalize
      Permalink::Permalizer.new(self).to_s
    end
  end
  
  class Permalizer
    
    # = Class variable which determines the Iconv fix method
    # us_ascii is the default
    @@translate_to = :us_ascii
    
    # = Class variable which determines whether the decompose hook is applied
    # defaults to false
    @@decompose_string = false
    

    class << self
      attr_accessor :decompose_string
      attr_accessor :translate_to
    end
    

    def initialize(word)
      # only if decompose_string is true and ActiveSupport is loaed in UTF-8 mode (with UTF8Handler as handler class)
      # This is required for some remote Linux machines, I regulary use it in production environment
      @word = word
      decompose! if Permalizer.decompose_string && word.respond_to?(:chars) && word.chars.respond_to?(:decompose)
    end
    
    # translate to us_ascii
    def us_ascii
      Iconv.new('US-ASCII//TRANSLIT', 'UTF-8').iconv @word
    end
    
    # translate to utf-8
    def utf_8
      Iconv.new('UTF-8//TRANSLIT//IGNORE', 'UTF-8').iconv @word
    end
    
    # translate to iso_8859_1
    def iso_8859_1
      Iconv.new('ISO-8859-1//TRANSLIT//IGNORE', 'UTF-8').iconv @word
    end
    
    
    def to_s
      transform send(@@translate_to)
    rescue
      transform us_ascii
    end
    
    protected
    
      # = Transform
      # Strips out unnecessary characters from any given word or phrase
      # 
      # * first strips non word characters, replacing it with nothing
      # * it keeps spaces and dashes, instead of replacing them with nothing
      # * does a second pass of removing non-word characters, replacing it with a space
      # * removes underscores, replacing it with a space
      # * then splits the phrase into an array
      # * rejoins the words with a dash
      # * then downcases the phrase
      def transform(word)
        word.gsub(/[^\w\s\-\—]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase
      end
    
    private
    
      def decompose!
        @word = @word.chars.decompose
      end
    
  end
end
