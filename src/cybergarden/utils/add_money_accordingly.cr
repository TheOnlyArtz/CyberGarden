def Cybergarden::Utilities.add_money_accordingly(id : Discord::Snowflake, time : Int32, garden : Cybergarden::Garden, connection : RethinkDB::Connection) : Int32
  now = Time.utc.to_unix
  diff = now - time # The difference in seconds

  r.db("cybergarden")
    .table("gardens")
    .get(id.to_s)
    .update({last_money_gain: now, money: garden.money + diff * garden.get_mps})
    .run(connection)

  garden.money + diff * garden.get_mps
end
