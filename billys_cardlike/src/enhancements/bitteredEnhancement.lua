SMODS.Enhancement {
    key = 'bitteredEnhancement',
    atlas = 'cardsAtlas',
    pos = { x = 2, y = 6 },
    config = {
        mult_chance = 3,
        mult_bonus = 20,
        money_chance = 10,
        money_bonus = 20
    },
    
    in_pool = function(self, args)
        return false, {allow_duplicates = false}
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { G.GAME.probabilities.normal, card.ability.mult_chance, card.ability.mult_bonus, card.ability.money_chance, card.ability.money_bonus } }
    end,
    
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local triggered = false
            local ret_table = {}
            
            if pseudorandom('custom_lucky_mult') < G.GAME.probabilities.normal / card.ability.mult_chance then
                ret_table.mult = card.ability.mult_bonus
                triggered = true
            end
            
            if pseudorandom('custom_lucky_money') < G.GAME.probabilities.normal / card.ability.money_chance then
                ret_table.dollars = card.ability.money_bonus
                triggered = true
            end
            
            if triggered then return ret_table end
        end
    end
}