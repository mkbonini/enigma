require './lib/enigma'

RSpec.describe Enigma do
    before(:each) do
        @enigma = Enigma.new
    end

    it '1. exists' do
        expect(@enigma).to be_a Enigma
    end

    describe '  encrypt  ##' do
        it '2. it takes all 3 arguements and returns a hash' do
            expect(@enigma.encrypt("hello world", "02715", "040895")). to be_a Hash
            expect(@enigma.encrypt("hello world", "02715", "040895").length). to eq 3
        end

        it '3. takes message and key arguments and returns a hash' do
            expect(@enigma.encrypt("hello world", "02715")). to be_a Hash
            expect(@enigma.encrypt("hello world", "02715").length). to eq 3
        end

        it '4. takes only a message and returns a hash' do
            expect(@enigma.encrypt("hello world", "02715", "040895")). to be_a Hash
            expect(@enigma.encrypt("hello world", "02715", "040895").length). to eq 3
        end

        it '5. sends back an encrypted message' do
            expect(@enigma.encrypt("hello world", "02715", "040895")). to eq({:encryption=>  "keder ohulw", :key=>"02715", :date=>"040895"})
        end
    end
    describe '  decrypt  ##' do
        it '6. it takes all 3 arguements and returns a hash' do
            expect(@enigma.decrypt("keder ohulw", "02715", "040895")). to be_a Hash
            expect(@enigma.decrypt("keder ohulw", "02715", "040895").length). to eq 3
        end

        it '7. takes message and key arguments and returns a hash' do
            expect(@enigma.decrypt("keder ohulw", "02715")). to be_a Hash
            expect(@enigma.decrypt("keder ohulw", "02715").length). to eq 3
        end

        it '8. sends back an decrypted message' do
            expect(@enigma.decrypt("keder ohulw", "02715", "040895")). to eq({:decryption=>  "hello world", :key=>"02715", :date=>"040895"})
        end

        it '9. can use todays date to decrypt messages' do
            encrypted = @enigma.encrypt("hello world", "02715")
            expect(@enigma.decrypt(encrypted[:encryption], "02715")[:decryption]).to eq("hello world")

            encrypted = @enigma.encrypt("!Alan Turing was the first to crack enigma!")
            expect(@enigma.decrypt(encrypted[:encryption], encrypted[:key])[:decryption]).to eq("!alan turing was the first to crack enigma!")
        end
    end

    describe '  Crack ##' do
        it '10. takes an encrypted message and date and reutrns a hash' do
            encrypted = @enigma.encrypt("hello world end","08304", "291018")
            expect(@enigma.crack(encrypted[:encryption], encrypted[:date])).to be_a Hash
            expect(@enigma.crack(encrypted[:encryption], encrypted[:date]).length).to eq 3
        end

        it '11. takes an encrypted message and reutrns a hash using todays date' do
            encrypted = @enigma.encrypt("hello world end")
            expect(@enigma.crack(encrypted[:encryption])).to be_a Hash
            expect(@enigma.crack(encrypted[:encryption]).length).to eq 3
        end

        it '12. can crack messages' do
            encrypted = @enigma.encrypt("hello world end")
            expect(@enigma.crack(encrypted[:encryption])[:decryption]).to eq "hello world end"
        end

        it '13. can crack longer messages with punctuation' do
            encrypted = @enigma.encrypt("!Alan Turing was the first to crack enigma! end")
            expect(@enigma.crack(encrypted[:encryption])[:decryption]).to eq "!alan turing was the first to crack enigma! end"
        end

        it '14. Can recognize false positives in the key cracking code' do
            encrypted = @enigma.encrypt("hello world end", "30993")
            expect(@enigma.crack(encrypted[:encryption])[:decryption]).to eq "hello world end"
            expect(@enigma.crack(encrypted[:encryption])[:key]).to eq "30993"
        end
    end
end