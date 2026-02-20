require("controls.pre_wormhole")
require("controls.post_wormhole")

script.on_load(function()    
    register_events()

    
end  ) 

script.on_init(function()
    register_events()

    register_technology_to_persist("oil-processing")
    register_technology_to_persist("wormhole-discovery")
    
end )



function register_events()
    if not remote.interfaces["wormholes-new-game-plus"] then
        log("missing the `wormholes-new-game-plus` dependency")
        return 
    end 

    local pre_wormhole_event_v = remote.call("wormholes-new-game-plus", "get_pre_wormhole_event")
    local post_wormhole_event_v = remote.call("wormholes-new-game-plus", "get_post_wormhole_event")

    script.on_event(pre_wormhole_event_v, function(event )
        pre_wormhole_event()
    end )

    script.on_event(post_wormhole_event_v, function(event)
        post_wormhole_event()
    end )
end 


remote.add_interface("wormholes-new-game-plus-technologies", {
  register_technology_to_persist = function(tech_name, safe_bool) register_technology_to_persist(tech_name, safe_bool) end ,
  get_pre_wormhole_event = function() return pre_wormhole_event end,
  get_post_wormhole_event = function() return post_wormhole_event end 
})


function register_technology_to_persist(tech_name, safe_bool) 
    if safe_bool == nil then 
        safe_bool = true
    end 
    if storage.safe_tech_names == nil then 
        
        storage.safe_tech_names = {} 
    end 

    if safe_bool then 
        storage.safe_tech_names[tech_name] = true
        
    elseif not safe_bool then 
        
        storage.safe_tech_names[tech_name] = false
    end 
end 
