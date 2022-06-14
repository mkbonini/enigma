require './lib/enigma'
require 'pry'

file_path = './text/' + ARGV[0]
message = File.read(file_path)

enigma = Enigma.new

cracked = enigma.crack(message, ARGV[2])

file_path = './text/' + ARGV[1]
File.write(file_path, cracked[:decryption])

puts "Created '#{ARGV[1]}' with the key #{cracked[:key]} and date #{cracked[:date]}"