def Cybergarden::Utilities.level_up(garden : Cybergarden::Garden, money : Int32, client : Cybergarden::Client) : Nil
  r.db("cybergarden")
    .table("gardens")
    .get(garden.owner_id)
    .update({level: garden.level + 1, money: money - garden.next_upgrade_requirements})
    .run(client.rethink.connection)

  nil
end
