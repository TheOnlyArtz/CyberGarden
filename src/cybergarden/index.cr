require "discordcr"
require "../../private/config.cr"

module Cybergarden
    class Client
        def initialize
            @client = Discord::Client.new(token: token, client_id: 657988561189994506_u64)
            @commands = Array(Nil) # to be Command
        end
    end
end

