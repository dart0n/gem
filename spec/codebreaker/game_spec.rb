# frozen_string_literal: true

require 'codebreaker'

RSpec.describe Game do
  let(:game) { described_class.new }

  context 'when .start called' do
    before { game.start('easy') }

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
    it "raises error if 'name' is invalid" do
      expect { game.registration('_') }.to raise_error(ArgumentError)
    end

    it "sets name for @user if 'name' valid" do
      game.registration('foobar')
      expect(game.user).not_to be nil
    end
  end

  context 'when .guess called' do
    it 'raises error if user number is invalid' do
      expect { game.guess(['']) }.to raise_error(ArgumentError)
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

  # context 'when .save_stats called' do
  #   before { game.start('easy') }

  #   let(:data) do
  #     { name: 'test', difficulty: 'easy', attempts_total: 15, attempts_used: 5, hints_total: 1, hints_used: 0 }
  #   end

  #   it 'invokes .save method' do
  #     expect(game).to have_received(:save).with(data)
  #   end
  # end
end
