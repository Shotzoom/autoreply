module Autoreply
  class Scanner::MicrosoftOutlook < Scanner::Base
    OUT_OF_OFFICE_PHRASES_REGEXPS = [
      /(O|o)ut\s(O|o)f(\s(T|t)he)?\s(O|o)ffice/,
      /(F|f)uera(\s(D|d)e)?(\s(L|l)a)?\s(O|o)ficina/
    ]

    def autoreply?
      outlook_x_mailer_header? && contains_out_of_office_phrase?
    end

    private

      def outlook_x_mailer_header?
        return false if x_mailer_header.nil?

        x_mailer_header.value =~ /((M|m)icrosoft\s)?(O|o)utlook/
      end

      def contains_out_of_office_phrase?
        result = OUT_OF_OFFICE_PHRASES_REGEXPS.inject([]) do |result, regexp|
          result << regexp if mail.body.to_s =~ regexp
          result
        end

        !result.empty?
      end

      def x_mailer_header
        mail.header_fields.detect {|header| header.name == "x-mailer" }
      end
  end
end
