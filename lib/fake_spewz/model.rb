require "fake_spewz/models/address_model"
require "fake_spewz/models/family_model"
require "fake_spewz/models/person_model"

module FakeSpewz
  class Model

    NAMESPACE_PREFIX = "FakeSpewz::Models"

    def initialize(child_klass_kind, options: {})
      @child_klass_kind = child_klass_kind.downcase
      @options = options
    end

    def call
      klass = child_klass
      klass.new(@options).call
    end

    # TODO: Provide a list of supported model kinds defined in child klass namespace
    def child_class_kinds
      []
    end

  private

    def child_klass
      ::Object.const_get(child_klass_namespace + "::" + child_klass_name)
    end

    def child_klass_name
      "#{@child_klass_kind.capitalize}" + "Model"
    end

    def child_klass_namespace
      parsed_class_name = parse_class_name(self.to_s)
      namespace = parsed_class_name[0]
      @child_klass_namespace = "#{namespace}" + "Models"
    end

    # Splits a class name into namespace and class name components
    def parse_class_name(full_class_name)
      names = full_class_name.split("::")

      # remove "::" prefix
      names.shift if names.size > 1 && names.first.empty?

      class_name = names.last
      namespace = names.slice!(-1).inject("") { |ns, name| ns = ns + "::" + name  }
      [namespace, class_name]
    end

  end
end