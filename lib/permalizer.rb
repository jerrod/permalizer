if defined?(Merb::Plugins)
  require 'iconv' # required for handling unicode/various languages

  module Merb #:nodoc:

    # Permalizer adds functionality to the String Object so that clean URLs creation is made simple
    module Permalizer

      # permalize! is a destructive method that will make the given string for use as a clean URL
      # <tt>example:</tt>
      # blog.title = "My Cool Merb Plugin!"
      # blog.title.permalize! # => "my-cool-merb-plugin"
      #
      def permalize!
        permalink!(self)
      end

      # permalize is the same as permalize! except that it is not a destructive method
      # it creates a duplicate of the string and returns it as a clean string for URL usage
      #
      def permalize
        string = self.dup
        permalink!(string)
      end

      private

        # permalink!
        # Fix unicode characters, regex unwanted characters, split string, thus removing all whitespace, join it, and downcase it                   
        #
        def permalink!(word)
          (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv word).gsub(/[^\w\s\-\—]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase  
        end  
    end
  end

  # mixin Permalizer in the String Object Class
  String.class_eval do
    include Merb::Permalizer
  end
  
end