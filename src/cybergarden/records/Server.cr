require "./CpuTypes.cr"
require "./ServerTypes.cr"
require "json"

abstract struct Cybergarden::Items::Server
    getter capacity : Int32
    getter processors : Array(Cybergarden::Items::Cpu)
    getter price : Int32 # money per second
    getter maintability : Int32  
    getter type  : Int32
    getter name : String

    def initialize()
        @capacity = 0_i32
        @processors = Array(Cybergarden::Items::Cpu).new
        @price = 0_i32
        @maintability = 0_i32
        @type = 0_i32
        @name = ""
    end
    
    def get_mps()
        mps = 0
        processors.each {|cpu| mps+=cpu.mps}
        mps
    end

    def as_h() : Hash(String, Int32 | String | Array(Hash(String, Int32)))
        prcsrs = Array(Hash(String, Int32)).new
        
        @processors.each do |pc|
            if prcsrs.find {|s| s["type"] == pc.type.to_i} == nil
                prcsrs << {"type" => pc.type.to_i, "count" => 1}
                next
            end

            curr = prcsrs.find{|s| s["type"] == pc.type.to_i}.not_nil!
            curr["count"] +=  1 
        end

        # pp "START", prcsrs, "END"
        {
            "processors" => prcsrs,
            "name" => @name,
            "type" => @type
        } 
    end

    def size() : Int32
        prcsrs = self.as_h["processors"]
        size = 0
        
        prcsrs.as(Array(Hash(String, Int32))).each do |pc|
            size += pc["count"]
        end

        size
    end
    def self.from_h(payload : Hash(String, RethinkDB::QueryResult)) : Cybergarden::Items::Server
        Cybergarden::Items::ServerTypes[payload["type"].as_i]
            .new(payload["processors"].as_a, payload["name"].to_s)
    end
end
