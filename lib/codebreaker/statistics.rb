# frozen_string_literal: true

require 'yaml'

module Statistics
  DIR_NAME = 'data'
  FILE_PATH = "./#{DIR_NAME}/stats.yml"

  def load_stats
    create_storage
    data = YAML.load_stream(File.read(FILE_PATH))
    sort_stats(data)
  end

  def save(data)
    data = new_rating.merge(data) # insert rating to the beginning
    File.open(FILE_PATH, 'a') { |file| file.write(data.to_yaml) }
  rescue StandardError
    create_storage
    retry
  end

  private

  def sort_stats(data)
    data.sort_by { |h| h[:difficulty] }.reverse.sort_by { |h| [h[:attempts_used], h[:hints_used]] }
  end

  def new_rating
    create_storage
    data = YAML.load_stream(File.read(FILE_PATH))
    { rating: data.size + 1 }
  end

  def create_storage
    Dir.mkdir(DIR_NAME) unless Dir.entries('.').include? DIR_NAME
    File.write(FILE_PATH, '') unless File.exist? FILE_PATH
  end
end
