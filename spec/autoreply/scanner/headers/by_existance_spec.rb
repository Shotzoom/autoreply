require "spec_helper"

describe Autoreply::Scanner::Headers::ByExistance do
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

      expect(described_class.new(mail.header_fields).autoreply?).to be_falsey
    end

    context "autoreplies" do
      described_class::KNOWN_HEADERS.each do |header|
        it "should detect `#{header} header" do
          mail = Mail.new(default_email_headers.merge({ "#{header}" => "somevalue" }))

          expect(described_class.new(mail.header_fields).autoreply?).to be_truthy
        end
      end
    end
  end
end
