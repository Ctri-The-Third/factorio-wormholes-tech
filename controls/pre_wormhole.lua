
function pre_wormhole_event()
    game.print("Tech mod detected a NGP pre-wormhole event")

    if storage.safe_tech_names == nil then


        register_technology_to_persist("oil-processing")
        register_technology_to_persist("wormhole-discovery")
        register_technology_to_persist("automation-science-pack")

    end 

    
    -- go through the forces and reset their technologies.
        for _, force in pairs(game.forces) do
            for _, tech in pairs(force.technologies) do
                if tech.valid then 
                    if storage.safe_tech_names[tech.name] then 
                    elseif tech.researched == true then 
                        tech.researched = false  
                    end  
                end 
            end  
            
            force.reset_technology_effects()
        end 
    
    
end 