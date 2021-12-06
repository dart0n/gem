# frozen_string_literal: true

class Game
  include Constants
  include Validation
  include Statistics

  attr_reader :secret_code, :difficulty, :attempts, :hints, :status, :user

  def start(difficulty)
    @secret_code = generate_code
    @difficulty = difficulty
    @attempts = DIFFICULTIES[difficulty.to_sym][:attempts]
    @hints = DIFFICULTIES[difficulty.to_sym][:hints]
    @status = PLAYING
  end

  def registration(name)
    @user = User.new(name)
  end

  def guess(number)
    return unless code_valid?(number)

    @attempts -= 1
    @status = LOSE if @attempts.zero?
    @status = WIN if number == @secret_code
    generate_guess_result(number)
  end

  def hint
    return if @hints.zero?

    @hints -= 1
    @secret_code[@hints + 1]
  end

  def save_stats
    data = {
      name: @user.name,
      difficulty: @difficulty,
      attempts_total: attempts_total,
      attempts_used: attempts_total - @attempts,
      hints_total: hints_total,
      hints_used: hints_total - @hints
    }
    save(data)
  end

  def show_stats
    load_stats
  end

  private

  def generate_code
    Array.new(CODE_LENGTH).map { rand(MIN_DIGIT..MAX_DIGIT) }
  end

  def generate_guess_result(user_number)
    code = @secret_code.dup
    result = user_number.each_with_object([]).with_index do |(digit, array), index|
      if code.any? digit
        array << (code[index] == digit ? SAME_POSITION : NOT_SAME_POSITION)
        code.collect! { |item| item if item != digit } # remove other duplicated digits
      end
    end
    result.compact.sort.join
  end

  def attempts_total
    DIFFICULTIES[@difficulty.to_sym][:attempts]
  end

  def hints_total
    DIFFICULTIES[@difficulty.to_sym][:hints]
  end
end
