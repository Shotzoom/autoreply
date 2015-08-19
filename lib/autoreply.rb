require "autoreply/version"
require "autoreply/scanner"
require "autoreply/scanner/base"
require "autoreply/scanner/sender"
require "autoreply/scanner/subject"
require "autoreply/scanner/headers"
require "autoreply/scanner/headers/base"
require "autoreply/scanner/headers/by_existance"
require "autoreply/scanner/headers/by_value"

module Autoreply
  extend self

  def autoreply?(mail)
    Scanner.new(mail).autoreply?
  end
end
