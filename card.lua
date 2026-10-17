local Card = {}
Card.__index = Card

Card.width = 80
Card.height = 112

function Card.new(rank, suit)
	local self = setmetatable({}, Card)
	self.rank = rank
	self.suit = suit

	-- cards initially appear near the deck
	self.x = 450
	self.y = 70
	self.targetX = self.x
	self.targetY = self.y

	self.dragging = false
	self.offsetX = 0
	self.offsetY = 0
	return self
end

function Card:setTarget(x, y)
	self.targetX = x
	self.targetY = y
end

function Card:contains(x, y)
	return x >= self.x and x <= self.x + Card.width and y >= self.y and y <= self.y + Card.height
end

function Card:mousepressed(x, y)
	if not self:contains(x, y) then
		return false
	end

	self.dragging = true
	self.offsetX = x - self.x
	self.offsetY = y - self.y

	return true
end

function Card:mousereleased()
	self.dragging = false
end

function Card:update(dt)
	if self.dragging then
		local mx, my = love.mouse.getPosition()
		self:setTarget(mx - self.offsetX, my - self.offsetY)
	end

	local speed = 15
	local t = 1 - math.exp(-speed * dt)

	self.x = self.x + (self.targetX - self.x) * t
	self.y = self.y + (self.targetY - self.y) * t
end

function Card:draw()
	local red = self.suit == "H" or self.suit == "D"

	-- Shadow
	love.graphics.setColor(0, 0, 0, 0.3)
	love.graphics.rectangle("fill", self.x + 4, self.y + 5, Card.width, Card.height, 5)

	-- Card face
	love.graphics.setColor(0.95, 0.95, 0.90)
	love.graphics.rectangle("fill", self.x, self.y, Card.width, Card.height, 5)

	if red then
		love.graphics.setColor(0.8, 0.15, 0.2)
	else
		love.graphics.setColor(0.1, 0.1, 0.1)
	end

	love.graphics.print(self.rank .. self.suit, self.x + 8, self.y + 8)
end

return Card
