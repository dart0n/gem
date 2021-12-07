# frozen_string_literal: true

require 'codebreaker/statistics'

RSpec.describe Statistics do
  it 'has a DIR_NAME' do
    expect(Statistics::DIR_NAME).not_to be nil
  end
end
