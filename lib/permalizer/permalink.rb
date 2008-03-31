
# Permalizer adds functionality to the String Object so that clean URLs creation is made simple
module Permalink

  # permalize! is a destructive method that will make the given string for use as a clean URL
  # example:
  # blog.title = "My Cool Gem!"
  # blog.title.permalize! # => "my-cool-gem"
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
    # TODO: Ruby 1.9 string encoding
    def permalink!(word)
      (Iconv.new('US-ASCII//TRANSLIT', 'utf-8').iconv word).gsub(/[^\w\s\-\—]/,'').gsub(/[^\w]|[\_]/,' ').split.join('-').downcase  
    end  
end
