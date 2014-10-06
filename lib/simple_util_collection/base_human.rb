class BaseHuman
  ALPHABET = '0123456789abcdefghjkmnprtuvwxyz'

  def self.encode( number )
    alphabet = ALPHABET

    unless number.to_s.match(/\A\d+\Z/) == nil ? false : true
      raise TypeError.new( 'Input must be an integer' )
    end

    # Special case for zero
    if number == 0
      return alphabet[0]
    end

    retval = ''
    sign = ''
    if number < 0
      sign = '-'
      number = 0 - number
    end

    while number != 0
      remainder = number % alphabet.length
      number = (number / alphabet.length).floor
      retval = alphabet[remainder] + retval
    end

    "#{sign}#{retval}"
  end

  def self.decode( string )
    alphabet = ALPHABET

    # Common replacements
    if string
      # all letters become downcase
      string.downcase!

      # i becomes a 1
      string.gsub!( /i/, '1')

      # l becomes a 1
      string.gsub!( /l/, '1')

      # o becomes a 0
      string.gsub!( /o/, '0')

      # s becomes a 5
      string.gsub!( /s/, '5')

      # q becomes a 9
      string.gsub!( /q/, '9')      
    end

    reversed_string = string.reverse

    retval = 0
    position = 0

    reversed_string.split(//).each do |char|
      retval += alphabet.index(char) * ( alphabet.length ** position )
      position += 1
    end

    retval
  end

end
