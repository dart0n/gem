# frozen_string_literal: true

class User
  include Validation

  attr_reader :name

  def initialize(name)
    @name = name if name_valid?(name)
  end
end
