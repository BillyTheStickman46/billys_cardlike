SMODS.Consumable {
    key = 'blankTarot',
    set = 'Tarot',
    atlas = 'cardsAtlas',
    pos = { x = 2, y = 4 },
    cost = 3,
    unlocked = true,
    
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted == 1 then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        local target_card = G.hand.highlighted[1]

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                target_card:flip()
                play_sound('tarot2', 1.0, 0.6)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                local blank_center = G.P_CENTERS.m_btspf_blankEnhancement
                if blank_center then
                    target_card:set_ability(blank_center)
                end
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                target_card:flip()
                play_sound('tarot2', 1.1, 0.6)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                target_card:juice_up(0.3, 0.3)
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}