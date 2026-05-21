SMODS.Consumable {
    key = 'balanceTarot',
    set = 'Tarot',
    atlas = 'cardsAtlas',
    pos = { x = 0, y = 4 },
    cost = 3,
    unlocked = true,
    
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted == 2 then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        local card1 = G.hand.highlighted[1]
        local card2 = G.hand.highlighted[2]

        local rank1 = card1.base.id
        local rank2 = card2.base.id

        local avg_rank_id = math.floor((rank1 + rank2) / 2)

        local rank_map = {
            [2] = '2', [3] = '3', [4] = '4', [5] = '5', [6] = '6', 
            [7] = '7', [8] = '8', [9] = '9', [10] = '10', 
            [11] = 'Jack', [12] = 'Queen', [13] = 'King', [14] = 'Ace'
        }

        local target_rank_string = rank_map[avg_rank_id]

        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                card1:flip()
                card2:flip()
                play_sound('tarot2', 1, 0.6)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                SMODS.change_base(card1, nil, target_rank_string)
                SMODS.change_base(card2, nil, target_rank_string)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 1, 
            func = function()
                card1:flip()
                card2:flip()
                play_sound('tarot2', 1.2, 0.6)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                card1:juice_up(0.3, 0.3)
                card2:juice_up(0.3, 0.3)
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}