require 'date'
require 'pry'
require './modules/gettable'

class Enigma

    include Gettable

    def initialize
        @alphabet = ("a".."z").to_a << " "
    end

    def encrypt(message, key = get_key, offset = get_offset)
        encrypted_message = ""
        shifts = get_shift(key, offset)
        i = 0
        message.downcase.each_char do |letter|
            if @alphabet.include?(letter)
                encrypted_message << get_letter(letter, shifts[i]) 
            else
                encrypted_message << letter
            end
            i == 3 ? i = 0 : i += 1
        end
        return_hash = {encryption: encrypted_message, key: key, date: offset}
    end

    def decrypt(message, key = get_key, offset = get_offset)
        decrypted_message = ""
        shifts = get_shift(key, offset)
        i = 0
        message.downcase.each_char do |letter|
            if @alphabet.include?(letter) 
                decrypted_message << get_decrypt_letter(letter, shifts[i])
            else
                decrypted_message << letter
            end
                i == 3 ? i = 0 : i += 1
        end
        return_hash = {decryption: decrypted_message, key: key, date: offset}
    end
end
