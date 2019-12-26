def Cybergarden::Commands.initialize_garden(cybergarden : Cybergarden::Client,
                                            message : Discord::Message,
                                             args : Array(String)) : Nil

    if Cybergarden::Utilities.get_garden?(message.author.id, cybergarden)
        cybergarden.client.create_message(message.channel_id, "Hey TheOnlyArtz, You already own a garden, type ;garden to see it.")
        return
    end
    
    payload = {
        id: message.author.id.to_s,
        money: 12000,
        last_money_gain: Time.utc.to_unix,
        servers: [] of Nil
    }

    r.db("cybergarden")
    .table("gardens")
    .insert(payload)
    .run(cybergarden.rethink.connection)

    content = "Congrats #{message.author.username}! I've created a fresh new garden for you!\nwith some money to start off!"
    cybergarden.client.create_message(message.channel_id, content)

    nil
end