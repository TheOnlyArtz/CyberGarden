require "./CpuTypes.cr"

abstract struct Cybergarden::Items::Cpu
  getter price : Int32
  getter power : Int32
  getter mps : Int32 # money per second
  getter type : Int32
  getter name : String

  def initialize
    @price = 0_i32
    @power = 0_i32
    @mps = 0_i32
    @type = 0_i32
    @name = ""
  end

  def as_h
    {
      "type" => @type,
    }
  end
end
