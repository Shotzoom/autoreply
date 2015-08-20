require "spec_helper"

describe Autoreply::Scanner do
  let(:mail) { Mail.new }
  let(:subject) { described_class.new(mail) }

  describe "#autoreply?" do
    it "should be truthy" do
      mail = Mail.new("x-precedence" => "bulk")
      subject = described_class.new(mail)

      expect(subject.autoreply?).to be_truthy
    end

    it "should be truthy" do
      mail = Mail.new("list-post" => "somevalue")
      subject = described_class.new(mail)

      expect(subject.autoreply?).to be_truthy
    end

    it "should be truthy" do
      mail = Mail.new(subject: "Auto:")
      subject = described_class.new(mail)

      expect(subject.autoreply?).to be_truthy
    end

    it "should be truthy" do
      mail = Mail.new(from: "noreply@example.com")
      subject = described_class.new(mail)

      expect(subject.autoreply?).to be_truthy
    end

    it "should be falsey" do
      expect(subject.autoreply?).to be_falsey
    end
  end

  describe "#sender_scanner" do
    it "should be instance of Autoreply::Scanner::Sender" do
      expect(subject.send(:sender_scanner)).to be_an(Autoreply::Scanner::Sender)
    end
  end

  describe "#subject_scanner" do
    it "should be instance of Autoreply::Scanner::Subject" do
      expect(subject.send(:subject_scanner)).to be_an(Autoreply::Scanner::Subject)
    end
  end

  describe "#headers_scanner" do
    it "should be instance of Autoreply::Scanner::Headers" do
      expect(subject.send(:headers_scanner)).to be_an(Autoreply::Scanner::Headers)
    end
  end

end
