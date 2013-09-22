--KGAME - Games for Achaea                    ---
--       Love Kurios                           --
-------------------------------------------------
kgame.active = false

kgame.activate = kgame.activate or tempAlias("^PLAY DOMINION$", [[kgame.activate()]]);


if(kgame.drawAlias) then
	killAlias(kgame.drawAlias)
end 
kgame.drawAlias = tempAlias("^DRAW (\\d+)" , [[kgame.draw(matches[2])]]);
if(kgame.discardAlias) then
	killAlias(kgame.discardAlias)
end
kgame.discardAlias = tempAlias("^DISCARD (\\w+)" , [[kgame.discard(matches[2])]]);
if (kgame.buyAlias) then
	killAlias(kgame.buyAlias)
end
kgame.buyAlias = tempAlias("^BUY (\\w+)",[[kgame.buy(matches[2])]]);
if (kgame.takeAlias) then
	killAlias(kgame.takeAlias)
end
kgame.takeAlias = tempAlias("^TAKE (\\w+)",[[kgame.take(matches[2])]]);
if (kgame.handAlias) then
	killAlias(kgame.handAlias)
end
kgame.handAlias = tempAlias("^SHOWHAND",[[kgame.showHand()]]);
if (kgame.trashAlias) then
	killAlias(kgame.trashAlias)
end 
kgame.trashAlias = tempAlias("^TRASH (\\w+)",[[kgame.take(matches[2])]]);
if (kgame.shuffleAlias) then
	killAlias(kgame.shuffleAlias)
end
kgame.shuffleAlias = tempAlias("^SHUFFLE",[[kgame.shuffle()]]);

kgame.deck = {};
kgame.discardPile = {};
kgame.hand = {};

function kgame.draw(i)
	if(matches[2]) then
		send("emote draws "..matches[2])
		matches[2] = nil
	end 
	i = tonumber(i)
	--display(i)
	if( (# kgame.deck) == 0 ) then
		kgame.shuffle()
	end
	if( (# kgame.deck) == 0 ) then
		cecho("<white>\n YOU DO NOT HAVE THAT MANY CARDS");
		return 0;
   end
	if (i == 0) then
		kgame.showHand()
	else
		table.insert(kgame.hand,table.remove(kgame.deck));
		kgame.draw(i-1)
   end
end

function kgame.swap(array, index1, index2)
	array[index1], array[index2] = array[index2], array[index1]
end

function kgame.shuffle()
	kgame.deck = kgame.discardPile;
	kgame.discardPile = {};
	local counter = #kgame.deck;
	while counter > 1 do
		local index = math.random(counter)
		kgame.swap(kgame.deck,index,counter)
		counter = counter - 1
	end
	send("emote shuffles thier deck")
end

function kgame.showHand() 
	if( (# kgame.hand) == 0 ) then
		cecho("<white>\n Your hand is empty");
	else
		cecho("<white>\nyour hand contains:\n")
		for i,v in pairs(kgame.hand) do
			cecho(v..", ");
		end
	end
end

function kgame.buy(item)
	--echo(item)
	send("get "..item)
	send("emote buys "..item);
	table.insert(kgame.discardPile,item)
end

function kgame.buyT(item)

end

function kgame.take(item)
	echo(item)
	send("get "..item)
	send("emote takes "..item)
	table.insert(kgame.hand,item)
end

function kgame.takeT(item)

end

function kgame.trash(item)
	index = -1;
	for i,v in pairs(kgame.hand) do
		if(v == item) then
		 index = i;
		end
	end
	--table.insert(kgame.discard,item)
	table.remove(kgame.hand,index)
	send("emote trashes "..item);
end

--function kgame.echo(item)
--	echo(item)
--end

function kgame.discard(item)
	if(item == "ALL")then
		for i,v in pairs(kgame.hand) do
			table.insert(kgame.discardPile,v)
		end
		kgame.hand = {}
		send("emote discards all");
	else
		index = -1
		for i,v in pairs(kgame.hand) do
			if(v == item) then
				index = i;
			end
		end
		table.insert(kgame.discardPile,item)
		table.remove(kgame.hand,index)
		send("emote discards "..item);
	end
end