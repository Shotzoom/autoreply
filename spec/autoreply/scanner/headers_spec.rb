require "spec_helper"

describe Autoreply::Scanner::Headers do
  let(:mail) { Mail.new(to: "to@example.com") }
  let(:subject) { described_class.new(mail) }

  describe "#autoreply?" do
    it "should be truthy" do
      mail = Mail.new("x-precedence" => "bulk")
      subject = described_class.new(mail)

      expect(subject.autoreply?).to be_truthy
    end

    it "should be falsey" do
      expect(subject.autoreply?).to be_falsey
    end
  end

  describe "#headers_by_existance" do
    it "should be an instance of Autoreply::Scanner::Headers::ByExistance" do
      expect(subject.send(:headers_by_existance)).to be_an_instance_of(Autoreply::Scanner::Headers::ByExistance)
    end
  end

  describe "#headers_by_value" do
    it "should be an instance of Autoreply::Scanner::Headers::ByValue" do
      expect(subject.send(:headers_by_value)).to be_an_instance_of(Autoreply::Scanner::Headers::ByValue)
    end
  end

  describe "#header_fields" do
    it "should return array of Mail::Field instances" do
      expect(subject.send(:header_fields)).to be_an(Array)

      last_header = subject.send(:header_fields).last

      expect(last_header).to be_an(Mail::Field)
      expect(last_header.name).to eq("To")
      expect(last_header.value).to eq("to@example.com")
    end
  end
end
