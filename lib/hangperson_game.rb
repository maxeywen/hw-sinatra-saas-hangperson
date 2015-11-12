class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(g)
    if /[[:alpha:]]/.match(g)
      g.downcase!
      if @word.include? g
        if @guesses.include? g
          return false
        else
          @guesses << g
        #@guesses << g unless @guesses.include? g
        end
      else
        if @wrong_guesses.include? g
          return false
        else
          @wrong_guesses << g
        #@wrong_guesses << g unless @wrong_guesses.include? g
        end
      end
    else
      raise ArgumentError
    end
  end
  
  def word_with_guesses
    wwg = ''
    word.each_char do |letter|
      if @guesses.include? letter
        wwg << letter
      else
        wwg << '-'
      end
    end
    return wwg
  end
  
  def check_win_or_lose
    if @word == word_with_guesses
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

end
