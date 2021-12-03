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
    @hints_values = @secret_code.sample(@hints)
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
    @hints_values.pop
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
    Array.new(4).map { rand(1..6) }
  end

  def generate_guess_result(user_number)
    result = user_number.map.with_index do |digit, index|
      if @secret_code.any? digit
        @secret_code[index] == digit ? SAME_POSITION : NOT_SAME_POSITION
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
