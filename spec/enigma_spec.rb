require './lib/enigma'

RSpec.describe Enigma do
    before(:each) do
        @enigma = Enigma.new
    end

    it '1. exists' do
        expect(@enigma).to be_a Engima
    end

    describe '## encrypt  ##' do
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
    end

end