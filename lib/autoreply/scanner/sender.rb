module Autoreply
  class Scanner::Sender < Scanner::Base
    KNOWN_SENDER_REGEXPS = [
      /^owner-/,
      /^request-/,
      /-request@/,
      /bounce.*@/,
      /-confirm@/,
      /-errors@/,
      /^no[-]?reply/,
      /^donotreply/,
      /^postmaster@/,
      /^mailer[-_]daemon@/,
      /^mailer@/,
      /^listserv@/,
      /^majordom[o]?@/,
      /^mailman@/,
      /^nobody@/,
      /^bounce/,
      /^www(-data)?@/,
      /^mdaemon@/,
      /^root@/,
      /^news(letter)?@/,
      /^webmaster@/,
      /^administrator@/,
      /^support@/
    ]

    def autoreply?
      !detected_senders.empty?
    end

    private

      def detected_senders
        from.inject([]) do |result, email|
          KNOWN_SENDER_REGEXPS.each do |regexp|
            result.push(email) if email =~ regexp
          end

          result
        end
      end

      # Sometimes non-standard emails are not parsed correctly. In this case Mail#from
      # return String instance instead of Array.
      #
      # Example email: "foo@bar.baz <>"
      #
      # Possibly related issue https://github.com/mikel/mail/issues/1141
      #
      def from
        mail.from ||= []

        if mail.from.is_a?(String)
          [mail.from]
        else
          mail.from
        end
      end
  end
end
