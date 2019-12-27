
# TODO: Write documentation for `Cybergarden`
require "crystal-rethinkdb"
require "json"

require "./cybergarden/index.cr"
require "./cybergarden/records/Garden"
require "./cybergarden/utils/*"
require "./cybergarden/commands/*"


include RethinkDB::Shortcuts
include Cybergarden::Utilities

module Cybergarden
  VERSION = "0.1.0"
  PREFIX = ";"
end

cybergarden = Cybergarden::Client.new()

cybergarden.client.on_message_create  do |msg|
  if !msg.content.starts_with? Cybergarden::PREFIX
    next
  end

  tokens = msg.content.split(';')[1].split(' ')
  command = tokens[0]
  tokens.delete_at(0)

  
  if command == "init"
    Cybergarden::Commands.initialize_garden(cybergarden, msg, tokens)
  elsif command == "stats"
    Cybergarden::Commands.garden_stats(cybergarden, msg, tokens)
  elsif command == "shop"
    Cybergarden::Commands.shop(cybergarden, msg, tokens)
  elsif command == "buy"
    Cybergarden::Commands.buy(cybergarden, msg, tokens)
  end
end

cybergarden.client.run