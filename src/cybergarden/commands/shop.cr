# pp Cybergarden::Items::CpuTypes[0].price
DESCRIPTION = Cybergarden::Items::CpuTypes.values.map { |x|
    curr = Cybergarden::Items::CpuTypes.from_value(x.to_i).to_cpu
    curr.description
}.join("\n")

def Cybergarden::Commands.shop(cybergarden : Cybergarden::Client,
                                        message : Discord::Message,
                                        args : Array(String)) : Nil

    embed = Discord::Embed.new(
        title: "The great hardware shop!",
        timestamp: Time.utc,
        description: DESCRIPTION,
        footer: Discord::EmbedFooter.new("To buy a new CPU go ahead and type #{Cybergarden::PREFIX}buy CPU <number> (e.g: buy CPU 0)")
    )

    cybergarden.client.create_message(message.channel_id, content: "", embed: embed)
end