require 'spec_helper'

RSpec.describe FakeSpewz::Models::PersonModel do

  let(:person_keys)  { 
        [
          :id, 
          :gender, 
          :name_prefix, 
          :first_name, 
          :middle_name, 
          :last_name, 
          :name_suffix, 
          :ssn, 
          :date_of_birth, 
          :is_incarcerated, 
          :is_disabled, 
          :uses_tobacco
      ]
    }
  
  context "with no traits specified" do
    it "should build a person instance populated with all attributes" do
      expect(FakeSpewz::Models::PersonModel.new.call.keys).to eq(person_keys)
    end
  end

  context "with one or more traits specified" do
    let(:first_name)    { "fox" }
    let(:last_name)     { "mulder" }
    let(:date_of_birth) { Date.new(1986,6,1) }
    let(:uses_tobacco)  { :unknown }
    let(:traits)        { 
                          { 
                            first_name: first_name,
                            last_name: last_name,
                            date_of_birth: date_of_birth,
                            uses_tobacco: uses_tobacco,
                            } 
                          }

    it "should build a person instance with the traits set to the specified values" do
      fake_person = FakeSpewz::Models::PersonModel.new(traits).call
      expect(fake_person[:first_name]).to eq(first_name)
      expect(fake_person[:last_name]).to eq(last_name)
      expect(fake_person[:date_of_birth]).to eq(date_of_birth)
      expect(fake_person[:uses_tobacco]).to eq(uses_tobacco)
    end
  end

  context "with age epoch trait specified" do
    


    
  end

end
