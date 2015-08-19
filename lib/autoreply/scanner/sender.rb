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
      !detected_senders.blank?
    end

    private

      def detected_senders
        mail.from ||= []
        mail.from.inject([]) do |result, email|
          KNOWN_SENDER_REGEXPS.each do |regexp|
            result.push(email) if email =~ regexp
          end

          result
        end
      end
  end
end
