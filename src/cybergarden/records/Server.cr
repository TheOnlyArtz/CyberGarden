require "./CpuTypes.cr"
require "./ServerTypes.cr"
require "json"

abstract struct Cybergarden::Items::Server
    getter capacity : Int32
    getter processors : Array(Cybergarden::Items::Cpu)
    getter price : Int32 # money per second
    getter maintability : Int32  
    getter type  : Int32

    def initialize()
        @capacity = 0_i32
        @processors = Array(Cybergarden::Items::Cpu).new
        @price = 0_i32
        @maintability = 0_i32
        @type = 0_i32
    end
    
    def get_mps()
        mps = 0
        processors.each {|cpu| mps+=cpu.mps}
        mps
    end

    def as_h()
        {
            processors: @processors.map &.as_h,
            type: @type
        } 
    end

    def self.from_h(payload : Hash(String, RethinkDB::QueryResult)) : Cybergarden::Items::Server
        Cybergarden::Items::ServerTypes[payload["type"].as_i].new payload["processors"].as_a
    end
end
