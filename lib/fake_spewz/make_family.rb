module FakeSpewz
  class MakeFamily < CompositeTask

    attr_reader :last_name

    def initialize(name, count = 1, member_range = 1..6)
      @name = "MakeFamily"
      @count = count
      @member_range = member_range

      add_subtask(FakeSpewz::MakeFamilyMember.new)
      add_subtask(FakeSpewz::MakeAddress.new)
    end


    def last_name
      return @last_name if defined?(@last_name)
      @last_name = _get_last_name
    end

    def home_address
    end

  private

    def _get_last_name
      # call redis function to return random family name here 
    end

  end
end
