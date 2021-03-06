require "autoreply/version"
require "autoreply/scanner"
require "autoreply/scanner/base"
require "autoreply/scanner/sender"
require "autoreply/scanner/subject"
require "autoreply/scanner/headers"
require "autoreply/scanner/microsoft_outlook"
require "autoreply/scanner/headers/base"
require "autoreply/scanner/headers/by_existance"
require "autoreply/scanner/headers/by_value"

module Autoreply
  extend self

  attr_accessor :allowed_senders

  def autoreply?(mail)
    return false if allowed_sender?(mail)

    Scanner.new(mail).autoreply?
  end

  def allowed_sender?(mail)
    (allowed_senders.to_a & mail.from.to_a).any?
  end
end
