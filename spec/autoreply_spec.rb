require "spec_helper"

describe Autoreply do
  it "has a version number" do
    expect(described_class::VERSION).not_to be nil
  end

  describe "#autoreply?" do
    before do
      Autoreply.allowed_senders = %w(noreply@white.list)
    end

    it "should respect allowed_senders" do
      mail = Mail.new(from: "noreply@white.list")

      expect(described_class.autoreply?(mail)).to be_falsey
    end
  end

  describe "#autoreply?" do
    before do
      Autoreply.allowed_senders = []
    end

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
