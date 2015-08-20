require "spec_helper"

describe Autoreply do
  it "has a version number" do
    expect(described_class::VERSION).not_to be nil
  end

  describe "#autoreply?" do
    it "should be truthy" do
      mail = Mail.new("x-precedence" => "bulk")

      expect(described_class.autoreply?(mail)).to be_truthy
    end

    it "should be truthy" do
      mail = Mail.new("list-post" => "somevalue")

      expect(described_class.autoreply?(mail)).to be_truthy
    end

    it "should be truthy" do
      mail = Mail.new(subject: "Auto:")

      expect(described_class.autoreply?(mail)).to be_truthy
    end

    it "should be truthy" do
      mail = Mail.new(from: "noreply@example.com")

      expect(described_class.autoreply?(mail)).to be_truthy
    end

    it "should be falsey" do
      mail = Mail.new

      expect(described_class.autoreply?(mail)).to be_falsey
    end
  end
end
