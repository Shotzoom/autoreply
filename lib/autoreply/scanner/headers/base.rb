module Autoreply
  class Scanner::Headers::Base
    attr_reader :header_fields

    def initialize(header_fields)
      @header_fields = header_fields ||= []
    end
  end
end
