# pp Cybergarden::Items::CpuTypes[0].price
DESCRIPTION_CPU = Cybergarden::Items::CpuTypes.values.map { |x|
    curr = Cybergarden::Items::CpuTypes.from_value(x.to_i).to_cpu
    curr.description
}.unshift("**CPU SHOP**").join("\n")

DESCRIPTION_SERVER = Cybergarden::Items::ServerTypes.map { |x|
    x.description
}.unshift("**SERVERS SHOP**").join("\n")

def Cybergarden::Commands.shop(cybergarden : Cybergarden::Client,
                                        message : Discord::Message,
                                        args : Array(String)) : Nil

    # TODO fix when garden is not available
    garden = Cybergarden::Utilities.get_garden(message.author.id, cybergarden)
    
    money = Cybergarden::Utilities.add_money_accordingly(message.author.id, garden.last_money_gain, garden, cybergarden.rethink.connection)
    
    embed_cpu = Discord::Embed.new(
        title: "The great hardware shop!",
        timestamp: Time.utc,
        fields: [
            Discord::EmbedField.new(
                inline: true,
                name: "Balance",
                value: money.humanize(precision: 2)
            )
        ],
        description: DESCRIPTION_CPU,
        footer: Discord::EmbedFooter.new("To buy a new CPU type\n #{Cybergarden::PREFIX}buy CPU <number> <amount> <servername> (e.g: buy CPU 0 1 ProCyber)")
    )

    embed_server = Discord::Embed.new(
        timestamp: Time.utc,
        fields: [
            Discord::EmbedField.new(
                inline: true,
                name: "Balance",
                value: money.humanize(precision: 2)
            )
        ],
        description: DESCRIPTION_SERVER,
        footer: Discord::EmbedFooter.new("To buy a new server type\n #{Cybergarden::PREFIX}buy SERVER <number> <amount> <servername> (e.g: buy server 0 1 ProCyber)")
    )
    cybergarden.client.create_message(message.channel_id, content: "", embed: embed_cpu)
    cybergarden.client.create_message(message.channel_id, content: "", embed: embed_server)
end