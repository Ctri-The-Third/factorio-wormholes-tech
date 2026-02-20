    if storage.safe_tech_names == nil then 
            storage.safe_tech_names = {}
            register_technology_to_persist("oil-processing")
            game.print("inited default tech safe list ")
    end
    game.print("migration complete!")