def Cybergarden::Commands.upgrade(cybergarden : Cybergarden::Client,
                                  message : Discord::Message,
                                  args : Array(String)) : Nil
  if !Cybergarden::Utilities.get_garden?(message.author.id, cybergarden)
    cybergarden.client.create_message(message.channel_id, "Looks like you don't own a garden :[ Please create one before proceeding!")
    return
  end

  garden = Cybergarden::Utilities.get_garden(message.author.id, cybergarden)
  money = Cybergarden::Utilities.add_money_accordingly(message.author.id, garden.last_money_gain, garden, cybergarden.rethink.connection)

  meets_requirements = money >= garden.next_upgrade_requirements

  if !meets_requirements
    content = "X - You don't have enough money to do so! (#{money.humanize(precision: 2)} out of #{garden.next_upgrade_requirements.humanize(precision: 2)})"
    cybergarden.client.create_message(message.channel_id, content)
    return
  end

  Cybergarden::Utilities.level_up(garden, money, cybergarden)
  cybergarden.client.create_message(message.channel_id, "+ Level up! You're now level **#{garden.level + 1}**")

  nil
end
