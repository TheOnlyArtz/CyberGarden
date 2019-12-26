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
                Cybergarden::Items::CpuTypes[cpu["type"].as_i]
                .new
                .as(Cybergarden::Items::Cpu)
            }
        end
    end
end