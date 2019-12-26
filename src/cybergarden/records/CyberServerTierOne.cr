require "./Server"
require "./CpuTypes"
module Cybergarden::Items
    struct CyberServerTierOne < Cybergarden::Items::Server
        def initialize(processors : Array(RethinkDB::QueryResult), @name : String)
            @capacity = 20
            @price = 10000
            @maintability = 1 # fairly low
            @type = 0

            @processors = processors.map { |cpu|
                Cybergarden::Items::CpuTypes
                .from_value(cpu["type"].as_i).to_cpu
            }
        end
    end
end