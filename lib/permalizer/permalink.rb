module Permalink # :nodo: 
  
  # Permalizer adds functionality to the String Object so that clean URLs creation is made simple
  #
  # It extend the string with <tt>permalize</tt> and <tt>permalize!</tt> which return permalized strings but
  # don't add the permalization process inside the string class, that process remains
  # in the Permalink::Permalizer class.
  #
  module InstanceMethods     
    # Transform the receiving string in a permalized string. Since this method is destructive, 
    # it should be used cautiously and only for things like clean user input:
    #
    #   post.permalink = "something UNTRUSTFUL that should be a permalink!"
    #   post.permalink.permalize! # => "something-untrustful-that-should-be-a-permalink"
    #
    def permalize!
      replace permalize
    end

    # permalize is the same as permalize! except that it is not a destructive method
    # it creates a duplicate of the string and returns it as a clean string for URL usage
    #
    
    # Returns a permalized copy of the string
    def permalize
      Permalink::Permalizer.new(self).to_s
    end
  end
  
  # Permalizer makes the permalization and holds configurations through fix methods
  #
  # === Configuration
  #
  # Permalizer has two class variables that makes configuration possible
  #
  # <tt>Permalizer.fix_method</tt>
  #
  # The vale of this variable determines the fix method that String.permalize will use. The default is <tt>:us_ascii</tt>.
  # Possible values are <tt>:iso_8859_1</tt> and <tt>:utf_8</tt>. *The class can be easily extendable to add more fix methods*
  #
  #   module Permalink
  #     class Permalizer
  #       def my_custom_fix_method
  #         Iconv.(from, to).iconv @word
  #       end
  #     end
  #   end
  #
  #   Permalink::Permalizer.fix_method = :my_custom_fix_method
  #
  # <tt>Permalizer.decompose_string</tt>
  #
  # Determines if the permalization must perform the special ActiveSupport method chars.decompose to fix some 
  # misunderstand of utf-8 characters in some machines. In these machines, a utf-8 string is scaped 
  # automatically before is stored and Iconv strips out these scaped characters
  #
  #   "españa".permalize # => "espaa"  [ugly permalization]
  #   Permalize.decompose_string = true
  #   "españa".permalize # => "espana" [desired permalization]
  #
  # If you want to use these feature, you must have ActiveSupport loaded and the UTF8Handler as the <tt>chars</tt> handler
  #
  class Permalizer
    
    @@fix_method = :us_ascii
    
    @@decompose_string = false
    
    class << self
      attr_accessor :decompose_string
      attr_accessor :fix_method
    end
    
    def initialize(word)
      @word = word
      decompose! if Permalizer.decompose_string && word.respond_to?(:chars) && word.chars.respond_to?(:decompose)
    end
    
    # Uses the US-ASCII encoding in the iconv conversion
    # This is the default fix method
    def us_ascii
      Iconv.new('US-ASCII//TRANSLIT', 'UTF-8').iconv @word
    end
    
    # Uses the UTF-8 encoding in the iconv conversion
    def utf_8
      Iconv.new('UTF-8//TRANSLIT//IGNORE', 'UTF-8').iconv @word
    end
    
    # Uses the ISO-8859-1 encoding in the iconv conversion
    def iso_8859_1
      Iconv.new('ISO-8859-1//TRANSLIT//IGNORE', 'UTF-8').iconv @word
    end
    
    # Calls the fix_method and transforms the string passed in the constructor in a url valid string
    def to_s
      transform send(@@fix_method)
    rescue
      transform us_ascii
    end
    
    protected
    
    # Strips no url valid characters, transform spaces in dashes and down case the passed string
    def transform(word)
      word.gsub(/[^\w\s\-\—]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase
    end
    
    private
    
    def decompose! # :nodoc:
      @word = @word.chars.decompose
    end
    
  end
end
