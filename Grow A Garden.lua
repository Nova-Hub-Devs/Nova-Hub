local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nova-Hub-Devs/Nova-Hub/refs/heads/main/game%20list.lua"))()

for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end
