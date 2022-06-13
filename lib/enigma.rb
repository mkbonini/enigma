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

    def crack(message, offset = get_offset)  
        shifts = get_crack_shifts(message)
        key = get_crack_key(shifts, offset)
        cracked = decrypt(message, key, offset)
        while cracked[:decryption][-4 .. -1] != " end"
            puts "did the thing"
            shifts[0] += 27
            key =  get_crack_key(shifts, offset)
            cracked = decrypt(message, key, offset)
        end
        cracked
    end

    def get_crack_shifts(message)
        shifts = []
        given = message[-4 .. -1]
        target = ' end'
        given.downcase.each_char.with_index do |letter,i|
            shift = @alphabet.index(letter) - @alphabet.index(target[i])
            shift = shift + 27 if shift < 0
            shifts <<  shift
        end
        corrected_shifts = get_corrected_shifts(message, shifts)
    end

    def get_corrected_shifts(message, shifts)
        corrected_shifts = Array.new(4)
        i = (message.length - 4) % 4
        shifts.each do |shift|
             corrected_shifts[i] = shift
             i == 3 ? i = 0 : i += 1
        end
        corrected_shifts
    end

    def get_crack_key(shifts, offset)
        test = offset
        offset = (offset.to_i ** 2).to_s[-4 .. -1]
        offsets = [offset[0].to_i, offset[1].to_i, offset[2].to_i, offset[3].to_i]
        keys = []
        shifts.map.with_index { |shift,i| shift - offsets[i] >= 0 ? keys << shift - offsets[i] : keys << (shift + 27) - offsets[i]}
        p keys
        original_keys = keys.dup
        key_strings = get_key_strings(keys)
        original_key_strings = key_strings.dup
        key_strings[1 .. 4].each.with_index do |key_string,i|
            while key_string[0] != key_strings[i][1]
                keys[i + 1] += 27
                if keys[i + 1] >= 100
                    keys[i] += 27
                    key_strings[i] = keys[i].to_s
                    # binding.pry
                    keys[i + 1] = original_keys[i + 1]
                    key_strings[i + 1] = original_key_strings[i + 1] 
                    # binding.pry 
                end
                key_string = keys[i + 1].to_s
            end
            key_strings[i+1] = key_string
        end
        key = key_strings[0] + key_strings[1][-1] + key_strings[2][-1] + key_strings[3][-1]
    end

    def get_key_strings(keys)
        key_check = keys.map {|key| 
            key_string = key.to_s
            key_string.prepend("0") until key_string.length == 2
            key_string
        }
    end
end
