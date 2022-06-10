require 'date'
require 'pry'

class Enigma

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

    def get_offset
        date = Date.today
        offset = date.strftime("%d") + date.strftime("%m") + date.strftime("%y") 
    end

    def get_key
       key = Random.rand(99999).to_s
       key.prepend("0") until key.length == 5
       key
    end

    def get_shift(key, offset)
        offset = (offset.to_i ** 2).to_s[-4 .. -1]
        keys = [key[0 .. 1].to_i, key[1 .. 2].to_i, key[2 .. 3].to_i, key[3 .. 4].to_i]
        offsets = [offset[0].to_i, offset[1].to_i, offset[2].to_i, offset[3].to_i]

        # shifts = {a: keys[0] + offsets[0], b: keys[1] + offsets[1], c: keys[2] + offsets[2], d: keys[3] + offsets[3]}
        shifts = [ keys[0] + offsets[0], keys[1] + offsets[1], keys[2] + offsets[2], keys[3] + offsets[3] ]
    end

    def get_letter(letter, shift)
        shift = shift % @alphabet.length if shift > @alphabet.length

        if (@alphabet.index(letter) + shift) <= 26
            new_index = @alphabet.index(letter) + shift
        else
            new_index = (27 - (@alphabet.index(letter) + shift)).abs
        end
        @alphabet[new_index]
    end

    def get_decrypt_letter(letter, shift)
        shift = shift % @alphabet.length if shift > @alphabet.length
        if (@alphabet.index(letter) - shift) >= 0
            new_index = @alphabet.index(letter) - shift
        else
            new_index = (27 - (shift - @alphabet.index(letter)))
        end

        @alphabet[new_index]
    end
end
