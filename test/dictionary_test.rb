require 'minitest/autorun'
require 'minitest/pride'
require './lib/dictionary'

class DictionaryTest < Minitest::Test

  def test_is_a_word
    dictionary = Dictionary.new
    assert dictionary.find_word("apple")
    assert dictionary.find_word("strawberry")
  end

  def test_isnt_a_word
    dictionary = Dictionary.new
    refute dictionary.find_word("adlkfjas")
    refute dictionary.find_word("fadkjhf")
  end

end
