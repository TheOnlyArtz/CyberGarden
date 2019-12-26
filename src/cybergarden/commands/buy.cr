def Cybergarden::Commands.buy(cybergarden : Cybergarden::Client,
    message : Discord::Message,
    args : Array(String)) : Nil

    if !Cybergarden::Utilities.get_garden?(message.author.id, cybergarden)
        cybergarden.client.create_message(message.channel_id, "Looks like you don't own a garden :[ Please create one before proceeding!")
        return
      end
      
    garden = Cybergarden::Utilities.get_garden(message.author.id, cybergarden)
    
    money = Cybergarden::Utilities.add_money_accordingly(message.author.id, garden.last_money_gain, garden, cybergarden.rethink.connection)

    if args.size < 4 || args.size > 4
        cybergarden.client.create_message(message.channel_id, "X - Expected 4 arguments but got #{args.size}")
        return
    end
    
    product, type, amount, name = args

    pp product, type, amount
    if product == "SERVER"
        
        if type.to_i == Cybergarden::Items::ServerTypes.size || type.to_i < 0
            cybergarden.client.create_message(message.channel_id, "X - This item does not exist! please try again.")
            return
        end

        if garden.servers.find {|i| i.name == name} != nil
            cybergarden.client.create_message(message.channel_id, "X - You already own a server with that name.")
            return
        end

        if money < Cybergarden::Items::ServerTypes[type.to_i].price
            cybergarden.client.create_message(message.channel_id, "X - You don't have enough money! Balance: #{money}")
            return
        end
        Cybergarden::Utilities.add_server(type.to_i, garden, money, name, cybergarden)
        cybergarden.client.create_message(message.channel_id, "You've just bought a new server! Enjoy **#{name}** it's all yours.")
    end

nil
end