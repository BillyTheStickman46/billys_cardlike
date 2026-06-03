SMODS.Enhancement {
    key = 'temperedGlassEnhancement',
    atlas = 'cardsAtlas',
    pos = { x = 4, y = 6 },
    config = { 
        x_mult = 2.0,
        shatter_chance = 8
    }, 

    in_pool = function(self, args)
        return false, {allow_duplicates = false}
    end,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_mult, G.GAME.probabilities.normal, card.ability.shatter_chance } }
    end,
    
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if not card.to_be_shattered and pseudorandom('tempered_glass_shatter') < G.GAME.probabilities.normal / card.ability.shatter_chance then
                card.to_be_shattered = true
                
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        card:shatter()
                        return true
                    end
                }))
            end
        end
    end
}