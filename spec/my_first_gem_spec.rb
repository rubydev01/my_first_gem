# frozen_string_literal: true

RSpec.describe MyFirstGem do
  it "has a version number" do
    expect(MyFirstGem::VERSION).not_to be nil
  end

  describe ".say_hi" do
    it "shows the message hello world" do
      greeting = described_class.say_hi
      message = "Hello world"
      expect(greeting).to eq(message)
    end
  end
end
