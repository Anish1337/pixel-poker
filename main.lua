function love.load()
	love.window.setTitle("love_poker")
	love.window.setMode(800, 600)
end

function love.draw()
	love.graphics.print("Hello, Poker!", 350, 280)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end
