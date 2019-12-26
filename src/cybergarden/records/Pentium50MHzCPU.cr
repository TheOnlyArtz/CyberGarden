require "./Cpu.cr"
module Cybergarden::Items
    struct Pentium50MHzCPU < Cybergarden::Items::Cpu
        def initialize()
            @price = 20
            @power = 50 # Power is in MHz
            @mps = 10
            @type = 0
        end
    end
end