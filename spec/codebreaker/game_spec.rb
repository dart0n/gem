# frozen_string_literal: true

require 'codebreaker'

RSpec.describe Codebreaker::Game do
  let(:game) { described_class.new }

  describe '.secret code' do
    it 'has a secret code' do
      expect(game.secret_code).not_to be nil
    end

    it 'is an array' do
      expect(game.secret_code).to be_a Array
    end

    it 'constains 4 digits' do
      expect(game.secret_code.size).to be 4
    end
  end

  context 'when .start called' do
    before { game.start('easy') }

    it 'has a difficulty' do
      expect(game.difficulty).not_to be nil
    end

    it 'has attempts' do
      expect(game.attempts).not_to be nil
    end

    it 'has hints' do
      expect(game.hints).not_to be nil
    end
  end

  context 'when .registration called' do
    it "doesn't set name for @user if 'name' is invalid" do
      game.registration('_')
      expect(game.user).to be nil
    end

    it "sets name for @user if 'name' valid" do
      game.registration('foobar')
      expect(game.user).not_to be nil
    end
  end

  context 'when .guess called' do
    it "doesn't change attempts if user number is invalid" do
      before_attempts = game.attempts
      game.guess([''])
      expect(game.attempts).to be before_attempts
    end

    it 'decrements @attempts if user number is valid' do
      game.start('easy')
      before_attempts = game.attempts
      game.guess([1, 2, 3, 4])
      expect(before_attempts - 1).to be game.attempts
    end
  end

  context 'when .hint called' do
    before { game.start('easy') }

    it "doesn't change hints if no hints left" do
      before_hints = game.hints
      game.hint
      before_hints = before_hints.negative? ? 0 : before_hints - 1
      expect(game.hints).to be before_hints
    end

    it 'decrements @hints' do
      before_hints = game.hints
      game.hint
      expect(before_hints - 1).to be game.hints
    end
  end
end
