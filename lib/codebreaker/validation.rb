# frozen_string_literal: true

module Validation
  include Constants

  def name_valid?(name)
    (name.size >= MIN_NAME_SIZE && name.size <= MAX_NAME_SIZE) || raise(ArgumentError)
  end

  def code_valid?(code)
    pattern = "^[#{MIN_DIGIT}-#{MAX_DIGIT}]{#{CODE_LENGTH}}$"
    code.join.match(/#{pattern}/) || raise(ArgumentError)
  end
end
