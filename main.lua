local Game = require("game")

local game

local streetNames = {
	"Preflop",
	"Flop",
	"Turn",
	"River",
}

function love.load()
	love.graphics.setBackgroundColor(0.08, 0.12, 0.10)
	game = Game.new()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	love.graphics.setColor(1, 1, 1)

	love.graphics.print("PIXEL POKER", 390, 40)
	love.graphics.print("Community Cards", 390, 150)
	love.graphics.print("Your Hand", 410, 355)

	game:draw()

	love.graphics.setColor(1, 1, 1)
	love.graphics.print("Street: " .. streetNames[game.street], 20, 20)

	love.graphics.print("Cards remaining: " .. game.deck:remaining(), 20, 45)

	love.graphics.print("RIGHT ARROW: Next street | R: New hand", 20, 550)
end

function love.keypressed(key)
	if key == "right" then
		game:advance()
	elseif key == "r" then
		game:reset()
	end
end

function love.mousepressed(x, y, button)
	if button ~= 1 then
		return
	end

	-- Check from topmost card to bottommost
	for i = #game.hand, 1, -1 do
		if game.hand[i]:mousepressed(x, y) then
			break
		end
	end
end

function love.mousereleased(x, y, button)
	if button ~= 1 then
		return
	end

	for _, card in ipairs(game.hand) do
		card:mousereleased()
	end
end
