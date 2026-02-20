require("controls.register_events")


function set_default_techs()
    if storage.safe_tech_names == nil then 
            storage.safe_tech_names = {}
            register_technology_to_persist("oil-processing")
            

    end 
end 


script.on_init(function()
    set_default_techs()
end )

