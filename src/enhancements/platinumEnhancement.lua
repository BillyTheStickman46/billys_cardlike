SMODS.Enhancement {
    key = "platinumEnhancement",
    atlas = "cardsAtlas",
    pos = { x = 6, y = 6 },
    config = { x_mult = 2.0 },
    
    in_pool = function(self, args)
        return false, {allow_duplicates = false}
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.hand and not context.blueprint then
            if context.main_scoring or context.repetition then
                return {
                    message = localize{type='variable', key='a_xmult', vars={card.ability.x_mult}},
                    x_mult = card.ability.x_mult,
                    card = card
                }
            end
        end
    end
}
