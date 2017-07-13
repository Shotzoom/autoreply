module Autoreply
  class Scanner
    attr_reader :mail

    def initialize(mail)
      @mail = mail
    end

    def autoreply?
      sender_scanner.autoreply?  ||
      subject_scanner.autoreply? ||
      headers_scanner.autoreply? ||
      microsoft_outlook_scanner.autoreply?
    end

    private

      def sender_scanner
        Scanner::Sender.new(mail)
      end

      def subject_scanner
        Scanner::Subject.new(mail)
      end

      def headers_scanner
        Scanner::Headers.new(mail)
      end

      def microsoft_outlook_scanner
        Scanner::MicrosoftOutlook.new(mail)
      end
  end
end
