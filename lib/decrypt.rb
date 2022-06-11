require './lib/enigma'
require 'pry'

file_path = './text/' + ARGV[0]
message = File.read(file_path)

enigma = Enigma.new

decrypted = enigma.decrypt(message, ARGV[2], ARGV[3])

file_path = './text/' + ARGV[1]
File.write(file_path, decrypted[:decryption])

puts "Created '#{ARGV[1]}' with the key #{decrypted[:key]} and date #{decrypted[:date]}"