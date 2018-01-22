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

  context "with id offset trait specified" do
    let(:id_offset) { 100_000 }
    let(:traits)    { { id_offset: id_offset } }

    it "should start at the offset value plus 1" do
      expect(FakeSpewz::Models::PersonModel.new(traits).call[:id]).to eq(id_offset + 1)
    end
  end

  context "with age epoch trait specified" do
    let(:child_epoch)           { :child }
    let(:child_under_26_epoch)  { :child_under_26 }
    let(:adult_epoch)           { :adult }
    let(:elder_epoch)           { :elder }


    it "and set to child, it should build a person instance with an in-range date of birth" do
      traits = { age_epoch: child_epoch}
      fake_person = FakeSpewz::Models::PersonModel.new(traits).call
      fake_person_age = ((Date.today - fake_person[:date_of_birth]).to_i / 365)
      expect(0..18).to cover(fake_person_age) 
    end

    it "and set to child under 26, it should build a person instance with an in-range date of birth" do
      traits = { age_epoch: child_under_26_epoch}
      fake_person = FakeSpewz::Models::PersonModel.new(traits).call
      fake_person_age = ((Date.today - fake_person[:date_of_birth]).to_i / 365)
      expect(0..26).to cover(fake_person_age) 
    end

    it "and set to adult, it should build a person instance with an in-range date of birth" do
      traits = { age_epoch: adult_epoch}
      fake_person = FakeSpewz::Models::PersonModel.new(traits).call
      fake_person_age = ((Date.today - fake_person[:date_of_birth]).to_i / 365)
      expect(18..64).to cover(fake_person_age) 
    end

    it "and set to elder, it should build a person instance with an in-range date of birth" do
      traits = { age_epoch: elder_epoch}
      fake_person = FakeSpewz::Models::PersonModel.new(traits).call
      fake_person_age = ((Date.today - fake_person[:date_of_birth]).to_i / 365)
      expect(65..120).to cover(fake_person_age) 
    end

    context "and date_of_birth is specified and it conflicts with epoch" do
      let(:date_of_birth)   { Date.today - 90 }
      let(:traits)          { {age_epoch: elder_epoch, date_of_birth: date_of_birth} }

      it "date of birth value should take precedent" do
        fake_person = FakeSpewz::Models::PersonModel.new(traits).call
        fake_person_age = ((Date.today - fake_person[:date_of_birth]).to_i / 365)
        expect(0..18).to cover(fake_person_age)
      end
    end

  end

end
