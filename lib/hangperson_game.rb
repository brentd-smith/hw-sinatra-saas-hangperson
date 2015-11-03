class HangpersonGame

  # simple change
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  # initialize
  # word = secret word person is trying to guess
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # returns false if letter g was guessed already, true otherwise
  # adds to guesses list if a correct guess (letter g is included in word)
  # adds to wrong_guesses list otherwise
  def guess(g)
    
    raise ArgumentError if (g == '' || g == nil || (g =~ /[^a-zA-Z]/))
    
    g.downcase!
    if @guesses.include?(g) || @wrong_guesses.include?(g)
      is_valid = false
    else
      is_valid = true
      
      if @word.include?(g)
        @guesses << g
      else
        @wrong_guesses << g
      end
    end

    return is_valid

  end


  # displays the word with correct guesses filled in
  # and remaining letters hidden with a "-" character
  def word_with_guesses
    
    display_word = @word
    @word.each_char do |w| 
        if !@guesses.include?(w)
          display_word = display_word.gsub(w, '-')
        end
    end

    return display_word
  end


  # returns either :win, :lose, or :play depending on the state of the game
  def check_win_or_lose
    if !letters_remaining? && guesses_remaining?
      :win
    elsif letters_remaining? && guesses_remaining?
      :play
    elsif !guesses_remaining?
      :lose
    end
    
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  # -----------------------------------------------------------------------
  # PRIVATE methods for helping only
  # -----------------------------------------------------------------------
  private
  
  # true if there has been less than 7 wrong guesses so far
  def guesses_remaining?
    return wrong_guesses.length < 7
  end
  
  # true if there exists a letter in @word that 
  # has not been guessed yet
  def letters_remaining?
      result = false
      @word.each_char do |w|
        if !@guesses.include?(w)
          result = true
          break
        end
      end
      return result
  end

end
