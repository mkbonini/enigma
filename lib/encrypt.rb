require './lib/enigma'
require 'pry'

file_path = './text/' + ARGV[0]
message = File.read(file_path)

enigma = Enigma.new

encrypted = enigma.encrypt(message)

file_path = './text/' + ARGV[1]
File.write(file_path, encrypted[:encryption])

puts "Created '#{ARGV[1]}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"