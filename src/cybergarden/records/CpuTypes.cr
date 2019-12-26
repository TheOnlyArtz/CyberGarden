enum Cybergarden::Items::CpuTypes
  Pentium50MHZ
  Pentium150MHZ
  
  def new : Cpu
    case self
    when Pentium50MHZ then create_cpu 20, 50, 3
    end.not_nil!
  end
  
  private def create_cpu(price : Int32, power : Int32, mps : Int32) : Cpu
    Cpu.new self, to_s, price, power, mps
  end
end
  
record Cybergarden::Items::Cpu, type : CpuTypes, name : String, price : Int32, power : Int32, mps : Int32