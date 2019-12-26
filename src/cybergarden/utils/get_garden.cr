def Cybergarden::Utilities.get_garden(id : Discord::Snowflake, cybergarden : Cybergarden::Client) : Cybergarden::Garden
  raw = r.db("cybergarden")
    .table("gardens")
    .get(id.to_s)
    .run(cybergarden.rethink.connection)

  Cybergarden::Garden.new raw.as_h
end

def Cybergarden::Utilities.get_garden?(id : Discord::Snowflake, cybergarden : Cybergarden::Client) : Bool
  raw = r.db("cybergarden")
    .table("gardens")
    .get(id.to_s)
    .run(cybergarden.rethink.connection)

  raw != nil
end
