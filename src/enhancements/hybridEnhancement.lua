SMODS.Enhancement {
    key = 'hybridEnhancement',
    atlas = 'cardsAtlas',
    pos = { x = 0, y = 6 },
    config = {
        bonus = 20,
        mult = 3
    },
    in_shop = true,
    weight = 1,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = { 
                card and card.ability.bonus or self.config.bonus, 
                card and card.ability.mult or self.config.mult 
            }
        }
    end
}