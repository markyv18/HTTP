class Dictionary
  def find_word(guess)
    words = File.open("/usr/share/dict/words", 'r')
    match = words.find do |word|
      word.chomp == guess
    end
  end
end
