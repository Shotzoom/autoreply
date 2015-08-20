require "spec_helper"

describe Autoreply::Scanner::Base do
  let(:mail) { Mail.new }

  describe "#autoreply?" do
    it "should raise error" do
      expect {
        described_class.new(mail).autoreply?
      }.to raise_error(NotImplementedError)
    end

    it "should raise error for child class" do

      class Foo < described_class
      end

      expect {
        Foo.new(mail).autoreply?
      }.to raise_error(NotImplementedError)
    end
  end
end
