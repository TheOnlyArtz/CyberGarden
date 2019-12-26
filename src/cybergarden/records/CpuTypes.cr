enum Cybergarden::Items::CpuTypes
  Pentium50MHZ
  
  def to_cpu : Cybergarden::Items::Cpu
    case self
    when Pentium50MHZ then create_cpu 20, 50, 20
    end.not_nil!
  end
  
  private def create_cpu(price : Int32, power : Int32, mps : Int32) : Cybergarden::Items::Cpu
    Cpu.new self, to_s, price, power, mps
  end

end
  
record Cybergarden::Items::Cpu, type : CpuTypes, name : String, price : Int32, power : Int32, mps : Int32 do
  def description
    "#{type.to_i}) **Name:** #{@name} | **Price:** #{@price}$ | **MPS:** #{@mps}$ | **Power:** #{@power}MHz"
  end
end