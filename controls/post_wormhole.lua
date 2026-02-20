
function post_wormhole_event()
    game.print("Tech mod detected a NGP post-wormhole event")
    for _, force in pairs(game.forces) do
        if force.technologies["wormhole-discovery"] then
            force.technologies["wormhole-discovery"].researched = true
        end
    end
end
    