require "spec_helper"

describe Autoreply::Scanner::Sender do
  let(:default_email_headers) {
    {
      to: "to@example.com",
      from: "from@example.com",
      subject: "Example subject",
      body: "Example body"
    }
  }

  # Emails witn non-ascii or special chars are not parsed correctly
  # and Mail#from returns String, not Array
  #
  # See https://github.com/mikel/mail/issues/1141
  #
  describe "#from" do
    it "should cast String to Array" do
      mail = Mail.new(from: "from@example.com <>")

      expect(described_class.new(mail).send(:from)).to eq(["from@example.com <>"])
    end
  end

  describe "#autoreply?" do
    it "should be false" do
      mail = Mail.new(default_email_headers)

      expect(described_class.new(mail).autoreply?).to be_falsey
    end

    context "autoreplies" do
      [
        "owner-",
        "request-",
        "-request",
        "bounce",
        "-confirm",
        "-errors",
        "noreply",
        "donotreply",
        "postmaster",
        "mailer-daemon",
        "mailer",
        "listserv",
        "majordomo",
        "mailman",
        "nobody",
        "www-data",
        "mdaemon",
        "root",
        "newsletter",
        "webmaster",
        "administrator",
        "support"
      ].each do |example|
        it "should detect `#{example}`" do
          mail = Mail.new(
            to: "to@example.com",
            from: "#{example}@example.com",
            subject: "Example email",
            body: "Example body"
          )

          expect(described_class.new(mail).autoreply?).to be_truthy
        end
      end
    end
  end
end
