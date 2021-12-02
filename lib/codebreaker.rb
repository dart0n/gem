# frozen_string_literal: true

require_relative 'codebreaker/version'
require_relative 'codebreaker/statistics'

module Codebreaker
  class Game
    include Statictics

    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    SAME_POSITION = '+'
    NOT_SAME_POSITION = '-'

    attr_reader :secret_code, :difficulty, :attempts, :hints, :status, :user

    def initialize
      @secret_code = generate_code
    end

    def start(difficulty)
      @difficulty = difficulty
      @attempts = DIFFICULTIES[difficulty.to_sym][:attempts]
      @hints = DIFFICULTIES[difficulty.to_sym][:hints]
      @status = 'playing'
    end

    def registration(name)
      @user = name if name.size >= 3 && name.size <= 20
    end

    def guess(number)
      return unless number.join.match(/^[1-6]{4}$/)

      @attempts -= 1
      @status = 'lose' if @attempts.zero?
      @status = 'win' if number == @secret_code
      generate_guess_result(number)
    end

    def hint
      return if @hints.zero?

      @hints -= 1
      @secret_code.sample
    end

    def save_stats
      data = {
        name: @user,
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
      result = user_number.map.with_index do |x, i|
        if @secret_code.any? x
          @secret_code[i] == x ? SAME_POSITION : NOT_SAME_POSITION
        end
      end
      result.compact.sort.join
    end

    def attempts_total
      DIFFICULTIES[difficulty.to_sym][:attempts]
    end

    def hints_total
      DIFFICULTIES[difficulty.to_sym][:hints]
    end
  end
end
