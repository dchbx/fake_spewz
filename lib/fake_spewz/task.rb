module FakeSpewz
  class Task

    attr_accessor :name, :parent

    def initialize(name, count)
      @name = name
      @count = count

      # Pointer to traverse upward from child tasks
      @parent = nil
    end

    private


  end
end
