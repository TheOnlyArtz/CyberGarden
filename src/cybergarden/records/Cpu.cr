require "./CpuTypes.cr"
abstract struct Cybergarden::Items::Cpu
    property price : Int32
    property power : Int32
    property mps : Int32 # money per second
    property type : Int32    

    def initialize()
        @price = 0_i32
        @power = 0_i32
        @mps = 0_i32
        @type = 0_i32
    end
    
    def as_h()
        {
            type: @type
        }
    end
end