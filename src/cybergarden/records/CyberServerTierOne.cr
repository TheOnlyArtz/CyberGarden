require "./Server"
require "./CpuTypes"

module Cybergarden::Items
    struct CyberServerTierOne < Cybergarden::Items::Server
        class_getter price : Int32 = 100000
        class_getter maintability : Int32 = 0
        class_getter capacity : Int32 = 10
        class_getter type : Int32 = 0

        def initialize(processors : Array(RethinkDB::QueryResult), @name : String)
            @capacity = @@capacity
            @price = @@price
            @maintability = @@maintability # fairly low
            @type = @@type
            @processors = Array(Cybergarden::Items::Cpu).new

            processors.each { |cpu|
                cpu["count"].as_i.times { |s|
                    a = Cybergarden::Items::CpuTypes
                    .from_value(cpu["type"].as_i).to_cpu
                    @processors << a
                }
            }
        end

        def self.description
         "#{@@type}) **Name:** #{self.name.split("Cybergarden::Items::")[1]} | **Price:** #{@@price}$ | **Capacity:** #{@@capacity}"
        end
    end
end
