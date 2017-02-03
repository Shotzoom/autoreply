module Autoreply
  class Scanner::Headers::ByExistance < Scanner::Headers::Base
    KNOWN_HEADERS = %w(
      list-help
      list-unsubscribe
      list-subscribe
      list-owner
      list-post
      list-archive
      list-id
      mailing-list
      x-facebook-notify
      x-mailing-list
      x-cron-env
      x-autoresponse
      x-ebay-mailtracker
      x-autoresponder
      x-autorespond
      auto-submitted
    )

    def autoreply?
      !(KNOWN_HEADERS & detected_headers).empty?
    end

    private

      def detected_headers
        header_fields.map(&:name).map(&:downcase)
      end
  end
end
