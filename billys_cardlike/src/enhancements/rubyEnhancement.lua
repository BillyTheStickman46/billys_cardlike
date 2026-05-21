SMODS.Enhancement {
    key = 'rubyEnhancement',
    atlas = 'cardsAtlas',
    pos = { x = 5, y = 6 },
    config = { 
        h_dollars = 5
    }, 

    in_pool = function(self, args)
        return false, {allow_duplicates = false}
    end,
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_dollars } }
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.end_of_round then
            return {
                dollars = card.ability.h_dollars
            }
        end
    end
}