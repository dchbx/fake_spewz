module FakeSpewz
  class MakePerson < Task

    def initialize
      super('Creating person')
      @person = FakeSpewz::Models::PersonModel.new
    end

    def first_name
    end

    def last_name
    end

    def date_of_birth
    end

    def ssn
    end

  end
end
