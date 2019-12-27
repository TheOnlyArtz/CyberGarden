def Cybergarden::Utilities.add_server(type : Int32, garden : Cybergarden::Garden, money : Int32, name : String, cybergarden : Cybergarden::Client) : Nil
    garden_db = r.db("cybergarden")
    .table("gardens")
    .get(garden.owner_id)

    garden_db
    .update { |u|
        {
            servers: u.get_field("servers").append({type: type, processors: [] of Nil, name: name}),
            money: money - Cybergarden::Items::ServerTypes[type].price
        }
    }
    .run(cybergarden.rethink.connection)

    nil
end