function love.load()
	love.graphics.setBackgroundColor(0.08, 0.12, 0.10)
end

function love.draw()
	love.graphics.print("Pixel Poker", 100, 60)

	-- Temporary card placeholder
	love.graphics.rectangle("line", 100, 120, 80, 112)
end

local card = {
	x = 100,
	y = 120,
	targetX = 100,
	targetY = 120,
	width = 80,
	height = 112,
	dragging = false,
	offsetX = 0,
	offsetY = 0,
}

function love.load()
	love.graphics.setBackgroundColor(0.08, 0.12, 0.10)
end

function love.mousepressed(x, y, button)
	if button ~= 1 then
		return
	end

	local inside = x >= card.x and x <= card.x + card.width and y >= card.y and y <= card.y + card.height

	if inside then
		card.dragging = true
		card.offsetX = x - card.x
		card.offsetY = y - card.y
	end
end

function love.mousereleased(x, y, button)
	if button == 1 then
		card.dragging = false
	end
end

function love.update(dt)
	if card.dragging then
		local mx, my = love.mouse.getPosition()

		card.targetX = mx - card.offsetX
		card.targetY = my - card.offsetY
	end

	-- Frame-rate independent smoothing
	local speed = 15
	local t = 1 - math.exp(-speed * dt)

	card.x = card.x + (card.targetX - card.x) * t
	card.y = card.y + (card.targetY - card.y) * t
end

function love.draw()
	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Pixel Poker", 100, 60)

	-- Shadow
	love.graphics.setColor(0, 0, 0, 0.3)
	love.graphics.rectangle("fill", card.x + 4, card.y + 5, card.width, card.height, 5)

	-- Card
	love.graphics.setColor(0.95, 0.95, 0.9)
	love.graphics.rectangle("fill", card.x, card.y, card.width, card.height, 5)

	love.graphics.setColor(0.1, 0.1, 0.1)
	love.graphics.print("A", card.x + 8, card.y + 8)
end
