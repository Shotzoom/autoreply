require "spec_helper"

describe Autoreply::Scanner::MicrosoftOutlook do
  let(:subject) { described_class.new(mail) }

  describe "#autoreply?" do
    context "when there is x-mailer header and body contains out of office text" do
      let(:mail) do
        Mail.new(
          "X-Mailer" => "Microsoft Outlook 14",
          "body" => "Sorry, I gonna be out of office until July 15."
        )
      end

      it "should be truthy" do
        expect(subject.autoreply?).to be_truthy
      end

      context "when out of office text is in Spanish" do
        let(:mail) do
          Mail.new(
            "X-Mailer" => "outlook",
            "body" => "Estar fuera de la oficina hasta el 24/07/2017"
          )
        end

        it "should be truthy" do
          expect(subject.autoreply?).to be_truthy
        end
      end
    end
  end
end
