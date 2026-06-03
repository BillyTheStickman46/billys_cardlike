SMODS.Enhancement {
    key = 'unsuitedEnhancement',
    atlas = 'cardsAtlas',
    pos = { x = 3, y = 6 },
    in_shop = true,
    weight = 1, 

    set_ability = function(self, card, initial)
        card.is_suit = function(self, suit, bypass_debuff)
            if not bypass_debuff and self.debuff then 
                return false 
            end
            
            return false
        end
    end,
}