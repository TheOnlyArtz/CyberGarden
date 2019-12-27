enum Cybergarden::Items::CpuTypes
  Pentium50MHZ
  Pentium150MHZ
  Pentium500MHZ
  Pentium1GHZ
  def to_cpu : Cybergarden::Items::Cpu
    case self
    when Pentium50MHZ then create_cpu 2000, 50, 10
    when Pentium150MHZ then create_cpu 20000, 150, 105
    when Pentium500MHZ then create_cpu 60000, 500, 310
    when Pentium1GHZ then create_cpu 100000, 1000, 625
    end.not_nil!
  end
  
  private def create_cpu(price : Int32, power : Int32, mps : Int32) : Cybergarden::Items::Cpu
    Cpu.new self, to_s, price, power, mps
  end

  def to_reql
    self.to_i
  end
end
  
record Cybergarden::Items::Cpu, type : CpuTypes, name : String, price : Int32, power : Int32, mps : Int32 do
  def description
    "#{type.to_i}) **Name:** #{@name} | **Price:** #{@price.humanize(precision: 2)}$ | **MPS:** #{@mps.humanize(precision: 2)}$ | **Power:** #{@power}MHz"
  end

  # Only serialize what the database needs
  def as_h
    {
      "type" => @type,
      "count" => 0
    } # The count will be modified whenever needed by outside methods
  end
end