def Cybergarden::Commands.initialize_garden(cybergarden : Cybergarden::Client,
                                            message : Discord::Message,
                                             args : Array(String)) : Nil

    garden = Cybergarden::Utilities.get_garden(message.author.id, cybergarden)
    if garden != nil
        cybergarden.client.create_message(message.channel_id, "Hey TheOnlyArtz, You already own a garden, type ;garden to see it.")
        return
    end
    
    payload = {
        id: message.author.id.to_s,
        money: 200,
        last_money_gain: Time.utc.to_unix,
        servers: [] of Nil
    }

    r.db("cybergarden")
    .table("gardens")
    .insert(payload)
    .run(cybergarden.rethink.connection)

    content = "Congrats #{message.author.username}! I've created a fresh new garden for you!"
    cybergarden.client.create_message(message.channel_id, content)

    nil
end