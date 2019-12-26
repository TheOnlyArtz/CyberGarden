require "./Server"
require "./CpuTypes"

module Cybergarden::Items
    struct CyberServerTierOne < Cybergarden::Items::Server
        class_getter price : Int32 = 10000
        class_getter maintability : Int32 = 0
        class_getter capacity : Int32 = 20
        class_getter type : Int32 = 0

        def initialize(processors : Array(RethinkDB::QueryResult), @name : String)
            @capacity = @@capacity
            @price = @@price
            @maintability = @@maintability # fairly low
            @type = @@type

            @processors = processors.map { |cpu|
                Cybergarden::Items::CpuTypes
                .from_value(cpu["type"].as_i).to_cpu
            }
        end

        def self.description
         "#{@@type}) **Name:** #{self.name.split("Cybergarden::Items::")[1]} | **Price:** #{@@price}$ | **Capacity:** #{@@capacity}"
        end
    end
end
