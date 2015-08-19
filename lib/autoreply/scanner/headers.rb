module Autoreply
  class Scanner::Headers < Scanner::Base
    def autoreply?
      headers_by_existance.autoreply? || headers_by_value.autoreply?
    end

    private

      def headers_by_existance
        Scanner::Headers::ByExistance.new(header_fields)
      end

      def headers_by_value
        Scanner::Headers::ByValue.new(header_fields)
      end

      def header_fields
        @header_fields ||= mail.header_fields
      end
  end
end
