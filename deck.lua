local Card = require("card")

local Deck = {}
Deck.__index = Deck

local suits = { "S", "H", "D", "C" }
local ranks = {
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"10",
	"J",
	"Q",
	"K",
	"A",
}

function Deck.new()
	local self = setmetatable({}, Deck)
	self.cards = {}

	for _, suit in ipairs(suits) do
		for _, rank in ipairs(ranks) do
			table.insert(self.cards, Card.new(rank, suit))
		end
	end

	self:shuffle()
	return self
end

function Deck:shuffle()
	-- Fisher-Yates shuffle
	for i = #self.cards, 2, -1 do
		local j = love.math.random(i)

		self.cards[i], self.cards[j] = self.cards[j], self.cards[i]
	end
end

function Deck:draw()
	assert(#self.cards > 0, "Deck is empty")
	return table.remove(self.cards)
end

function Deck:remaining()
	return #self.cards
end

return Deck
