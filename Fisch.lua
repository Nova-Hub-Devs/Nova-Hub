local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nova-Hub-Devs/Nova-Hub/refs/heads/main/2-Game%20lister.lua"))()

for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end
