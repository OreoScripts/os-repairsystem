Config = {}

Config.Mechanics = {
    { -- Mechanic 1
        coords = vec3(-212.0682, -1324.342, 30.468223), -- Drawtext + Blip Coords
        showBlip = true, -- If You Wany A Blip Or Not.
        blipData = { -- https://docs.fivem.net/docs/game-references/blips/
            sprite = 446, -- Blip Sprite
            display = 4, -- Leave it 4
            scale = 0.6, -- scale , i recommend 0.6
            colour = 66, -- blip color - https://docs.fivem.net/docs/game-references/blips/ 
            title = "Bennys", -- What Title you want for the blip or its just "Bennys"
            minZ = 29.468223, -- for polyzone(whre the drawtext will be)
            maxZ = 31.468223  -- for polyzone(whre the drawtext will be)
        }
    },
    --{ -- Mechanic 2
        -- coords = vector3(-338.9632, -136.7556, 39.009613), -- Drawtext + Blip Coords
        -- showBlip = true, -- If You Wany A Blip Or Not.
        -- blipData = { -- https://docs.fivem.net/docs/game-references/blips/
        --     sprite = 446, -- Blip Sprite
        --     display = 4, -- Leave it 4
        --     scale = 0.6, -- scale , i recommend 0.6
        --     colour = 66, -- blip color - https://docs.fivem.net/docs/game-references/blips/ 
        --     title = "Bennys", -- What Title you want for the blip or its just "Bennys"
        --     minZ = 37.468223, -- for polyzone(whre the drawtext will be)
        --     maxZ = 41.468223,  -- for polyzone(whre the drawtext will be)
        --}
    --},
}
