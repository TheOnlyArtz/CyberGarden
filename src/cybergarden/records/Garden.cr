require "./Server"
require "./ServerTypes"

struct Cybergarden::Garden
    getter servers : Array(Cybergarden::Items::Server)
    getter owner_id : String # UInt64 for Discord.cr
    getter last_money_gain : Int32
    getter money : Int32

    def initialize(payload : Hash(String, RethinkDB::QueryResult))
        @owner_id = payload["id"].to_s
        @money = payload["money"].as_i
        @last_money_gain = payload["last_money_gain"].as_i
        @servers = payload["servers"].as_a.map { |server|
            Cybergarden::Items::Server
            .from_h(server.as_h)
            .as(Cybergarden::Items::Server)
        }
    end

    def as_h
        {
            "owner_id" => @owner_id,
            "last_money_gain" => @last_money_gain,
            "money" => @money,
            "servers" => @servers.map &.as_h
        }
    end

    def get_mps()
        mps = 0
        servers.each {|server| mps += server.get_mps}
        mps
    end
end