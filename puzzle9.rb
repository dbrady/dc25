#!/usr/bin/env ruby

# puzzle image at http://dc25.minervallux.com/challenge/includes/puzzle-9.png

# Logically this works out to:

# a = ((A ^ B) & (C ^ D))
# b = (a & (E & F))
# c = (b ^ d)
# d = ((A ^ C) & (F ^ D))

inputs = %w(101010 101011 111011 000011 001011 001110 100011 011010).map {|word| word.split(//).map{|char| char.to_i(2)} }

puts inputs.map {|input_digits| input_digits * ', '}


def a(i)
  (i[0] | i[1]) & (i[2] | i[3])
end

def b(i)
  a(i) & (i[4] & i[5])
end

def c(i)
  b(i) | d(i)
end

def d(i)
  (i[0] | i[2]) & (i[5] | i[3])
end

def word(input)
  a(input) << 3 +
    b(input) << 2 +
    c(input) << 1 +
    d(input) << 0
end

inputs.each do |input|
  puts "%d%d%d%d => %d" % [a(input), b(input), c(input), d(input), word(input)]
end
