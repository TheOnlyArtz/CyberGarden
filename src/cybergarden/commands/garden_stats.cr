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
    # thumbnail: Discord::EmbedThumbnail.new(message.author.avatar),
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
        value: "#{garden.servers.size} out of #{Cybergarden::Garden.server_capacity(garden.level)}"
      ),
      Discord::EmbedField.new(
        inline: true,
        name: "Level",
        value: garden.level.to_s
      ),
      Discord::EmbedField.new(
        name: "Level Progress (cost: #{garden.next_upgrade_requirements.humanize(precision: 2)})",
        value: garden.get_progress_bar
      ),
    ],
    description: description,
    colour: 16728579_u32,
    footer: Discord::EmbedFooter.new("Use the command #{Cybergarden::PREFIX}upgrade in order to buy a new level!")
  )

  cybergarden.client.create_message(message.channel_id, content: "", embed: embed)

  nil
end
