def Cybergarden::Commands.garden_stats(cybergarden : Cybergarden::Client,
                                        message : Discord::Message,
                                        args : Array(String)) : Nil


  if !Cybergarden::Utilities.get_garden?(message.author.id, cybergarden)
    cybergarden.client.create_message(message.channel_id, "Looks like you don't own a garden :[ Please create one before proceeding!")
    return
  end
  garden = Cybergarden::Utilities.get_garden(message.author.id, cybergarden)

  money = Cybergarden::Utilities.add_money_accordingly(message.author.id, garden.last_money_gain, garden, cybergarden.rethink.connection)

  description = garden.servers.map do |e|
    "[#{e.name}] -> #{e.size} CPUs out of #{e.capacity}"
  end
  
  description.unshift("```css")
  description.unshift("")
  description << ("\n```")
  description = description.join("\n")

  embed = Discord::Embed.new(
    title: "Stats for #{message.author.username}'s garden",
    timestamp: Time.utc,
    thumbnail: Discord::EmbedThumbnail.new("https://images.discerningassets.com/image/upload/q_auto:best/c_limit,h_1000,w_1000/v1567910812/IMG_8659_2_pqb1m6.jpg"),
    fields: [
      Discord::EmbedField.new(
        inline: true,
        name: "Money",
        value: money.humanize(precision: 2)
      ),
      Discord::EmbedField.new(
        inline: true,
        name: "Money per second",
        value: garden.get_mps.to_s
      ),
      Discord::EmbedField.new(
        inline: true,
        name: "Total Servers",
        value: garden.servers.size.to_s
      )
    ],
    description: description,
    colour: 16728579_u32
  )

  
  cybergarden.client.create_message(message.channel_id, content: "", embed: embed)

  nil
end