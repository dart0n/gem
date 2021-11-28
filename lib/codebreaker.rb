# frozen_string_literal: true

require_relative 'codebreaker/version'

module Codebreaker
  class Game
    DIFFICULTIES = {
      easy: { attempts: 15, hints: 2 },
      medium: { attempts: 10, hints: 1 },
      hell: { attempts: 5, hints: 1 }
    }.freeze

    attr_reader :secret_code, :attempts, :hints

    def initialize(name, difficulty)
      @username = name
      @attempts = DIFFICULTIES[difficulty.to_sym][:attempts]
      @hints = DIFFICULTIES[difficulty.to_sym][:hints]
      @secret_code = generate_code
    end

    private

    def generate_code
      Array.new(4).map { rand(1..6) }.join
    end
  end
end
