require "./Server"
require "./ServerTypes"

struct Cybergarden::Garden
  getter servers : Array(Cybergarden::Items::Server)
  getter owner_id : String # UInt64 for Discord.cr
  getter last_money_gain : Int32
  getter money : Int32
  getter level : Int32

  def initialize(payload : Hash(String, RethinkDB::QueryResult))
    @owner_id = payload["id"].to_s
    @money = payload["money"].as_i
    @last_money_gain = payload["last_money_gain"].as_i
    @level = payload["level"].as_i

    @servers = payload["servers"].as_a.map { |server|
      Cybergarden::Items::Server
        .from_h(server.as_h)
        .as(Cybergarden::Items::Server)
    }
  end

  def as_h
    {
      "owner_id"        => @owner_id,
      "last_money_gain" => @last_money_gain,
      "money"           => @money,
      "servers"         => @servers.map &.as_h,
      "level"           => @level,
    }
  end

  def get_mps
    mps = 0
    servers.each { |server| mps += server.get_mps }
    mps
  end

  # Returns the amount of money required to level up
  def get_next_upgrade_requirement : Int32
    (@level * 1.75 * 1e6.to_i).to_i
  end

  def get_progress_bar : String
    requirement = self.get_next_upgrade_requirement
    progress = ((@money / requirement) * 10).to_i

    bar = "["
    progress.times { |i| bar += "===" if i < 10 }
    (10 - progress).times { |_| bar += "---" }
    bar += "]"
    bar += " ✅" if progress >= 1
    bar
  end
end
