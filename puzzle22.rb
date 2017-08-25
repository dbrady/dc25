#!/usr/bin/env ruby
require 'colorize'

ciphertext = <<CIPHER
BCS BGVAWJ LIU VAXVAVBU:
BGU YAVPULJU LAT GYQLA
JBYHVTVBZ; LAT V'Q ASB
JYLU IKSYB BGU YAVPULJU.
CIPHER

key = {
  "V" => "i",
  "Q" => "m",
  "A" => "n",
  "X" => "f",
  "B" => "t",
  "U" => "e",
  "S" => "o",
  "C" => "w",
  "G" => "h",
  "W" => "g",
  "J" => "s",
  "Y" => "u",
  "I" => "r",
  "P" => "v",
  "L" => "a",
  "T" => "d",
  "H" => "p",
  "Z" => "y"

}


histogram = Hash.new 0

letters = ciphertext.each_line.to_a.flatten.join('').gsub(/[^A-Z]/,'')
puts letters
letters.each_char do |c|
  histogram[c] += 1
end

puts histogram.each_pair.to_a.sort_by {|char, count| count }.map {|char, count| "%2d %c %s" % [count, char, key[char]] }


solution = ciphertext
key.each do |cipher, key|
  solution.gsub!(cipher, key.green)
end

puts solution
