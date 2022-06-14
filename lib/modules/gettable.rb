  module Gettable
  
    def get_date
        date = Date.today
        offset = date.strftime("%d") + date.strftime("%m") + date.strftime("%y") 
    end

    def get_key
       key = Random.rand(99999).to_s
       key.prepend("0") until key.length == 5
       key
    end

    def get_offsets(date)
        offset = (date.to_i ** 2).to_s[-4 .. -1]
        offsets = [offset[0].to_i, offset[1].to_i, offset[2].to_i, offset[3].to_i]
    end

    def get_shift(key, date)
        keys = [key[0 .. 1].to_i, key[1 .. 2].to_i, key[2 .. 3].to_i, key[3 .. 4].to_i]
        offsets = get_offsets(date)

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

    def get_crack_shifts(message)
        shifts = []
        given = message[-4 .. -1]
        target = ' end'
        given.downcase.each_char.with_index do |letter,i|
            shift = @alphabet.index(letter) - @alphabet.index(target[i])
            shift = shift + 27 if shift < 0
            shifts <<  shift
        end
        corrected_shifts = get_corrected_shifts(message.length, shifts)
    end

    def get_corrected_shifts(length, shifts)
        corrected_shifts = Array.new(4)
        i = (length - 4) % 4
        shifts.each do |shift|
             corrected_shifts[i] = shift
             i == 3 ? i = 0 : i += 1
        end
        corrected_shifts
    end

    def get_crack_key(shifts, date)
        offsets = get_offsets(date)
        keys = []
        shifts.map.with_index { |shift,i| shift - offsets[i] >= 0 ? keys << shift - offsets[i] : keys << (shift + 27) - offsets[i]}
        original_keys = keys.dup
        key_strings = get_key_strings(keys)
        original_key_strings = key_strings.dup
        key_strings[1 .. 4].each.with_index do |key_string,i|
            while key_string[0] != key_strings[i][1]
                keys[i + 1] += 27
                if keys[i + 1] >= 100
                    keys[i] += 27
                    key_strings[i] = keys[i].to_s
                    keys[i + 1] = original_keys[i + 1]
                    key_strings[i + 1] = original_key_strings[i + 1] 
                end
                key_string = keys[i + 1].to_s
            end
            key_strings[i+1] = key_string
        end
        key = key_strings[0] + key_strings[1][-1] + key_strings[2][-1] + key_strings[3][-1]
    end

    def get_key_strings(keys)
        key_check = keys.map do |key| 
            key_string = key.to_s
            key_string.prepend("0") until key_string.length == 2
            key_string
        end
    end
end