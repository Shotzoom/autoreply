module Autoreply
  class Scanner::Base
    attr_reader :mail

    def initialize(mail)
      @mail = mail
    end

    def autoreply?
      raise NotImplementedError
    end
  end
end
