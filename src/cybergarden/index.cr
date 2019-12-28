require "discordcr"

require "../../private/config.cr"

include RethinkDB::Shortcuts

module Cybergarden
  class Client
    getter client
    getter rethink

    def initialize
      @client = Discord::Client.new(token: token, client_id: 657988561189994506_u64)
      @cache = Discord::Cache.new(@client)
      @client.cache = @cache
      @rethink = Rethink.new
    end
  end

  class Rethink
    property connection : RethinkDB::Connection
    property db

    def initialize
      @connection = r.connect(host: "localhost")
    end
  end

  module Commands
  end

  module Utilities
  end
end
