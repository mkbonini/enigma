require 'date'
require 'pry'
require './lib/modules/gettable'

class Enigma

    include Gettable

    def initialize
        @alphabet = ("a".."z").to_a << " "
    end

    def encrypt(message, key = get_key, offset = get_date)
        encrypted_message = ""
        shifts = get_shift(key, offset)
        message.downcase.each_char.with_index do |letter, i|
            if @alphabet.include?(letter)
                encrypted_message << get_letter(letter, shifts[i % 4]) 
            else
                encrypted_message << letter
            end
        end
        return_hash = {encryption: encrypted_message, key: key, date: offset}
    end

    def decrypt(message, key = get_key, offset = get_date)
        decrypted_message = ""
        shifts = get_shift(key, offset)
        message.downcase.each_char.with_index do |letter,i|
            if @alphabet.include?(letter) 
                decrypted_message << get_decrypt_letter(letter, shifts[i % 4])
            else
                decrypted_message << letter
            end
        end
        return_hash = {decryption: decrypted_message, key: key, date: offset}
    end

    def crack(message, offset = get_date)  
        shifts = get_crack_shifts(message)
        key = get_crack_key(shifts, offset)
        cracked = decrypt(message, key, offset)
        while cracked[:decryption][-4 .. -1] != " end"
            shifts[0] += 27
            key =  get_crack_key(shifts, offset)
            cracked = decrypt(message, key, offset)
        end
        cracked
    end
end
