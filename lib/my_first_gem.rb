# frozen_string_literal: true

require_relative "my_first_gem/version"

module MyFirstGem
  class Error < StandardError; end

  def self.say_hi
    "Hello world"
  end
end
