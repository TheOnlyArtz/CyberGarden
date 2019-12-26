# pp Cybergarden::Items::CpuTypes[0].price
DESCRIPTION = Cybergarden::Items::CpuTypes.values.map { |x|
    curr = Cybergarden::Items::CpuTypes.from_value(x.to_i).to_cpu
    curr.description
}.unshift("**CPU SHOP**").join("\n")

def Cybergarden::Commands.shop(cybergarden : Cybergarden::Client,
                                        message : Discord::Message,
                                        args : Array(String)) : Nil

    garden = Cybergarden::Utilities.get_garden(message.author.id, cybergarden)
    money = Cybergarden::Utilities.add_money_accordingly(message.author.id, garden.last_money_gain, garden, cybergarden.rethink.connection)
    
    embed = Discord::Embed.new(
        title: "The great hardware shop!",
        timestamp: Time.utc,
        fields: [
            Discord::EmbedField.new(
                inline: true,
                name: "Balance",
                value: money.humanize(precision: 2)
            )
        ],
        description: DESCRIPTION,
        footer: Discord::EmbedFooter.new("To buy a new CPU type\n #{Cybergarden::PREFIX}buy CPU <number> <amount> <servername> (e.g: buy CPU 0 1 ProCyber)")
    )

    cybergarden.client.create_message(message.channel_id, content: "", embed: embed)
end