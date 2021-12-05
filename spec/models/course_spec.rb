require 'rails_helper'

RSpec.describe Course, type: :model do
    
    subject {
        described_class.new(name: "Test Course 1", release_date: "2022-01-02")
    }

    it 'is valid with valid attributes' do
        expect(subject).to be_valid
    end

    it 'is not valid without a name' do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it 'is not valid without a release date' do 
        subject.release_date = nil
        expect(subject).to_not be_valid
    end

    it 'is not valid without a valid release date format' do 
        subject.release_date = "02-22-2022"
        expect(subject).to_not be_valid
    end

end