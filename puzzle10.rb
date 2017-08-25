#!/usr/bin/env ruby

# Who wrote the thin vigenere of a Hackers quote?

# Assumption: ciphertext is a quote from Hackers, and the Vigenere key that
# encrypts it is the answer. There are 14 letters in the answer.


ciphertext = <<CIPHER
oaeulru ymtgx
keumyido dhcd ahgi
ko cc wlcimunvf
ctohtkfl ptyilgw
zonfpni
CIPHER

# We can't use patterns here, but we CAN look for a quote with the same number
# of words and same letters in each word. A known-plaintext attack against
# Vigenere should then be trivial.


words = ciphertext.each_line.map {|line| line.split}.flatten
sentence = words * ' '
puts "Cipher: #{words * ' '}"
puts words

puts "Number of characters (counting spaces): %d" % words.inject(0) { |sum, word| sum + word.size }
puts "Number of words: %d" % words.size
puts "Word lengths: " + words.map(&:size) * ' '


puts '-' * 80

# return vigenere ciphertext of one character
# E.g. A, A => A; D, C => F
def envigenerate(plain, key)
  boundary = plain == plain.upcase ? "Z" : "z"
  cipher = plain.ord + (key.ord - 65)
  cipher -= 26 if cipher > boundary.ord
  cipher.chr
end

def devigenerate(cipher, key)
  boundary = cipher == cipher.upcase ? "A" : "a"
  plain = cipher.ord - (key.ord - 65)
  plain += 26 if plain < boundary.ord
  plain.chr
end

def encode(text, key)
  key = key.split(//).cycle
  text.split(//).map {|c| c =~ /[A-Za-z]/ ? envigenerate(c, key.next) : c }.join('')
end

def decode(text, key)
  key = key.split(//).cycle
  text.split(//).map {|c| c =~ /[A-Za-z]/ ? devigenerate(c, key.next) : c }.join('')
end

puts "Caesar Test:"
plain = "ABCDE"
key = "D"
codewheel = key.split(//).cycle.take(plain.size).join('')

cipher = encode plain, key
puts "%s => %s" % [plain, cipher]
puts "%s" % codewheel

new_plain = decode cipher, key
puts "%s => %s" % [cipher, new_plain]
puts "%s" % codewheel

puts "-" * 10

puts "Vigenere test:"
plain = "Attack at dawn!"
key = "CRYPTO"
codewheel = key.split(//).cycle.take(plain.size).join('')

cipher = encode plain, key
puts "%s => %s" % [plain, cipher]
puts "%s" % codewheel

new_plain = decode cipher, key
puts "%s => %s" % [cipher, new_plain]
puts "%s" % codewheel

puts "-" * 10

puts "Can we decrypt yet test:"
key = "ABCD"
puts decode ciphertext, key


puts "=" * 80
puts "Okay, hang on to your butts..."
puts "Loading dictionary..."

words = File.readlines("/usr/share/dict/words").map {|word| word.strip}

keyspace = 26**4

# run and done. Key is "HACK". Because obviously.

start = Time.now
("A".."Z").each do |a|
  puts "Starting on the #{a}'s..."
  ("A".."Z").each do |b|
    puts "  #{Time.now} #{a}#{b} #{keyspace} possibilities left in keyspace.."
    ("A".."Z").each do |c|
      puts "    #{Time.now} #{a}#{b}#{c}.."
      ("A".."Z").each do |d|
        keyspace -= 1
        key = a + b + c + d
        plain = decode sentence, key
        matches = plain.split.keep_if {|word| words.include? word }
        if matches.size > 6
          puts key
          puts plain
          exit
        end
      end
    end
  end
end
