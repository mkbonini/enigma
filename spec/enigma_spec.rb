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

        it '3. it takes message and date arguements and returns a hash' do
            expect(@enigma.encrypt("hello world", "02715", "040895")). to be_a Hash
            expect(@enigma.encrypt("hello world", "02715", "040895").length). to eq 3
        end 

        it '4. takes message and key arguments and returns a hash' do
            expect(@enigma.encrypt("hello world", "02715", "040895")). to be_a Hash
            expect(@enigma.encrypt("hello world", "02715", "040895").length). to eq 3
        end

        it '5. takes only a message and returns a hash' do
            expect(@enigma.encrypt("hello world", "02715", "040895")). to be_a Hash
            expect(@enigma.encrypt("hello world", "02715", "040895").length). to eq 3
        end

        it '6. sends back an encrypted message' do
            expect(@enigma.encrypt("hello world", "02715", "040895")). to eq({:encryption=>  "keder ohulw", :key=>"02715", :date=>"040895"})
        end
    end
    describe '  decrypt  ##' do
        it '7. it takes all 3 arguements and returns a hash' do
            expect(@enigma.decrypt("keder ohulw", "02715", "040895")). to be_a Hash
            expect(@enigma.decrypt("keder ohulw", "02715", "040895").length). to eq 3
        end

        it '8. takes message and key arguments and returns a hash' do
            expect(@enigma.decrypt("keder ohulw", "02715")). to be_a Hash
            expect(@enigma.decrypt("keder ohulw", "02715").length). to eq 3
        end

        it '9. sends back an decrypted message' do
            expect(@enigma.decrypt("keder ohulw", "02715", "040895")). to eq({:decryption=>  "hello world", :key=>"02715", :date=>"040895"})
        end

        it '10. can use todays date to decrypt messages' do
            encrypted = @enigma.encrypt("hello world", "02715")
            expect(@enigma.decrypt(encrypted[:encryption], "02715")[:decryption]).to eq("hello world")

            encrypted = @enigma.encrypt("!Alan Turing was the first to crack enigma!")
            expect(@enigma.decrypt(encrypted[:encryption], encrypted[:key])[:decryption]).to eq("!alan turing was the first to crack enigma!")
        end
    end
end