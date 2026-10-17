local Deck = require("deck")

local Game = {}
Game.__index = Game

Game.STREET = {
	PREFLOP = 1,
	FLOP = 2,
	TURN = 3,
	RIVER = 4,
}

function Game.new()
	local self = setmetatable({}, Game)
	self:reset()
	return self
end

function Game:reset()
	self.deck = Deck.new()
	self.hand = {}
	self.community = {}
	self.burned = {}

	self.street = Game.STREET.PREFLOP

	-- Deal two hole cards
	for i = 1, 2 do
		local card = self.deck:draw()
		card:setTarget(355 + i * 90, 390)
		table.insert(self.hand, card)
	end
end

function Game:burn()
	table.insert(self.burned, self.deck:draw())
end

function Game:dealCommunity(count)
	for _ = 1, count do
		local card = self.deck:draw()
		local index = #self.community + 1

		card:setTarget(180 + index * 95, 190)
		table.insert(self.community, card)
	end
end

function Game:advance()
	if self.street == Game.STREET.PREFLOP then
		self:burn()
		self:dealCommunity(3)
		self.street = Game.STREET.FLOP
	elseif self.street == Game.STREET.FLOP then
		self:burn()
		self:dealCommunity(1)
		self.street = Game.STREET.TURN
	elseif self.street == Game.STREET.TURN then
		self:burn()
		self:dealCommunity(1)
		self.street = Game.STREET.RIVER
	end
end

function Game:update(dt)
	for _, card in ipairs(self.hand) do
		card:update(dt)
	end

	for _, card in ipairs(self.community) do
		card:update(dt)
	end
end

function Game:draw()
	for _, card in ipairs(self.community) do
		card:draw()
	end

	for _, card in ipairs(self.hand) do
		card:draw()
	end
end

return Game
