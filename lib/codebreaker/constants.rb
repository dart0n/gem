# frozen_string_literal: true

module Constants
  DIFFICULTIES = {
    easy: { attempts: 15, hints: 2 },
    medium: { attempts: 10, hints: 1 },
    hell: { attempts: 5, hints: 1 }
  }.freeze

  SAME_POSITION = '+'
  NOT_SAME_POSITION = '-'

  # statuses
  PLAYING = 'playing'
  WIN = 'win'
  LOSE = 'lose'

  MIN_DIGIT = 1
  MAX_DIGIT = 6
  CODE_LENGTH = 4
end
