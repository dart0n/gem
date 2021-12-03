# frozen_string_literal: true

module Validation
  include Constants

  def name_valid?(name)
    (name.size >= 3 && name.size <= 20) || raise(ArgumentError)
  end

  def code_valid?(code)
    pattern = "^[#{MIN_DIGIT}-#{MAX_DIGIT}]{#{CODE_LENGTH}}$"
    code.join.match(/#{pattern}/) || raise(ArgumentError)
  end
end
