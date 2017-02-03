require "spec_helper"

describe Autoreply::Scanner::Subject do
  let(:default_email_headers) {
    {
      to: "to@example.com",
      from: "from@example.com",
      subject: "Example subject",
      body: "Example body"
    }
  }

  describe "#autoreply?" do
    it "should be false" do
      mail = Mail.new(default_email_headers)

      expect(described_class.new(mail).autoreply?).to be_falsey
    end

    context "autoreplies" do
      context "when subject contains autoresponder words" do
        it "should be true" do
          mail = Mail.new(
            to: "to@example.com",
            from: "from@example.com",
            subject: "Sorry, I'm on vacation (Out of Office - US Open)",
            body: "Example body"
          )

          expect(described_class.new(mail).autoreply?).to be_truthy
        end
      end

      described_class::KNOWN_SUBJECTS.each do |subject|
        it "should detect `#{subject}`" do
          mail = Mail.new(
            to: "to@example.com",
            from: "from@example.com",
            subject: subject,
            body: "Example body"
          )

          expect(described_class.new(mail).autoreply?).to be_truthy
        end
      end
    end
  end
end
