SMODS.Enhancement {
    key = 'magmaEnhancement',
    atlas = 'cardsAtlas',
    pos = { x = 7, y = 6 },
    
    config = { 
        bonus = 50,
        mult = 6
    }, 

    in_pool = function(self, args)
        return false, {allow_duplicates = false}
    end,
    
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    
    loc_vars = function(self, info_queue, card)
        local chips = card and card.ability and card.ability.bonus or 50
        local mult = card and card.ability and card.ability.mult or 6
        return { vars = { chips, mult } }
    end
}