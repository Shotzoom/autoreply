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
      x-auto-response-suppress
    )

    def autoreply?
      !(KNOWN_HEADERS & header_fields.map(&:name).map(&:downcase)).blank?
    end
  end
end
