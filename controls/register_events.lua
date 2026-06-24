require("controls.pre_wormhole")
require("controls.post_wormhole")




local function fetch_event_ids()
    if not remote.interfaces["wormholes-new-game-plus"] then 
        log("missing the `wormholes-new-game-plus` dependency")
        storage.pre_wormhole_event_id = nil 
        storage.post_wormhole_event_id = nil 
        return 
    end 
    storage.pre_wormhole_event_id = remote.call("wormholes-new-game-plus", "get_pre_wormhole_event")
    storage.post_wormhole_event_id = remote.call("wormholes-new-game-plus", "get_post_wormhole_event")
    
end 

local function register_handlers()
    if storage.pre_wormhole_event_id then 
        script.on_event(storage.pre_wormhole_event_id, function(event) pre_wormhole_event() end)
    end 
    if storage.post_wormhole_event_id then 
        script.on_event(storage.post_wormhole_event_id, function(event) post_wormhole_event() end)
    end
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


function init_events()
        fetch_event_ids()
        register_handlers()
end 


script.on_load(function()    
    register_handlers()

    
end  ) 
script.on_configuration_changed(function()
    fetch_event_ids()
    register_handlers()
end )

