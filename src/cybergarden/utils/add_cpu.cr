def Cybergarden::Utilities.add_cpu(type : Int32,
                                   garden : Cybergarden::Garden,
                                   money : Int32,
                                   server_name : String,
                                   amount : Int32,
                                   cybergarden : Cybergarden::Client) : Nil
  garden_db = r.db("cybergarden")
    .table("gardens")
    .get(garden.owner_id)

  ss = garden_db.run(cybergarden.rethink.connection).as_h
  server = garden.servers.find { |d| d.name == server_name }.not_nil!
  servers = garden.servers
  payload = Array(Hash(String, Array(Hash(String, Int32)) | Int32 | String)).new

  payload = servers.map &.as_h

  if server.processors.find { |d| d.type.to_i == type.to_i } == nil
    processors = payload.find { |d| d["name"] == server_name }.not_nil!["processors"]
      .as(Array(Hash(String, Int32)))

    processors << {"type" => type.to_i, "count" => amount.to_i}
  else
    processors = payload.find { |d| d["name"] == server_name }.not_nil!["processors"]
      .as(Array(Hash(String, Int32)))

    raw = processors.find { |d| d["type"] == type }.not_nil!
    raw["count"] += amount
  end

  garden_db
    .update { |d|
      {
        servers: payload,
        money:   money - Cybergarden::Items::CpuTypes.from_value(type.to_i).to_cpu.price.to_i * amount,
      }
    }.run(cybergarden.rethink.connection)
  nil
end
