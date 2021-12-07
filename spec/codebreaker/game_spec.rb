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

      it 'constains specific number of digits' do
        expect(game.secret_code.size).to be Constants::CODE_LENGTH
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
    context 'when invalid name' do
      it "raises error if 'name' is less than minimum length" do
        expect { game.registration('a' * (Constants::MIN_NAME_SIZE - 1)) }.to raise_error(ArgumentError)
      end

      it "raises error if 'name' is greater than maximum length" do
        expect { game.registration('a' * (Constants::MAX_NAME_SIZE + 1)) }.to raise_error(ArgumentError)
      end
    end

    it "sets name for @user if 'name' valid" do
      game.registration(FFaker::Name.unique.first_name)
      expect(game.user).not_to be nil
    end
  end

  context 'when .guess called' do
    before { game.start('easy') }

    let!(:before_attempts) { game.attempts }

    it 'raises error if user number is invalid' do
      expect { game.guess(['']) }.to raise_error(ArgumentError)
    end

    it 'decrements @attempts if user number is valid' do
      game.guess(Array.new(Constants::CODE_LENGTH).map { rand(Constants::MIN_DIGIT..Constants::MAX_DIGIT) })
      expect(before_attempts - 1).to be game.attempts
    end

    context 'when user guessing' do
      before { game.instance_variable_set(:@secret_code, [6, 5, 4, 3]) }

      it 'returns ++-- if secret code is 6543 and user number is 5643' do
        expect(game.guess([5, 6, 4, 3])).to eq '++--'
      end

      it 'returns +- if secret code is 6543 and user number is 6411' do
        expect(game.guess([6, 4, 1, 1])).to eq '+-'
      end

      it 'returns ---- if secret code is 6543 and user number is 3456' do
        expect(game.guess([3, 4, 5, 6])).to eq '----'
      end

      it 'returns + if secret code is 6543 and user number is 6666' do
        expect(game.guess([6, 6, 6, 6])).to eq '+'
      end

      it 'returns - if secret code is 6543 and user number is 2666' do
        expect(game.guess([2, 6, 6, 6])).to eq '-'
      end

      it "returns '' if secret code is 6543 and user number is 2222" do
        expect(game.guess([2, 2, 2, 2])).to eq ''
      end

      it 'returns ++++ if secret code is 6543 and user number is 6543' do
        expect(game.guess([6, 5, 4, 3])).to eq '++++'
      end
    end
  end

  context 'when .hint called' do
    before { game.start('easy') }

    let!(:before_hints) { game.hints }

    it 'decrements @hints' do
      game.hint
      expect(before_hints - 1).to be game.hints
    end

    it "doesn't change hints if no hints left" do
      game.instance_variable_set(:@hints, 0)
      game.hint
      expect(game.hints).to be_zero
    end
  end

  context 'when .save_stats called' do
    let!(:name) { FFaker::Name.unique.first_name }
    let!(:data) do
      {
        name: name,
        difficulty: 'easy',
        attempts_total: 15,
        attempts_used: 5,
        hints_total: 1,
        hints_used: 0
      }
    end

    before do
      game.start('easy')
      game.registration(name)
      game.save_stats
    end

    it 'invokes .save method' do
      allow(game).to receive(:save)
      game.save(data)
      expect(game).to have_received(:save).with(data)
    end
  end

  context 'when .show_stats called' do
    before do
      game.show_stats
    end

    it 'invokes .load_stats method' do
      allow(game).to receive(:load_stats)
      game.load_stats
      expect(game).to have_received(:load_stats)
    end
  end
end
