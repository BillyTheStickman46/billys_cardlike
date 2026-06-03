SMODS.Consumable {
    key = 'altarSpectral',
    set = 'Spectral',
    atlas = 'cardsAtlas',
    pos = { x = 0, y = 5 },
    cost = 4,
    unlocked = true,
    hidden = true,
    
    can_use = function(self, card)
        if G.hand and G.hand.cards and #G.hand.cards > 0 
           and G.jokers and G.jokers.config and G.jokers.config.card_limit and #G.jokers.cards < G.jokers.config.card_limit 
           and G.GAME and G.GAME.dollars >= 20 then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        ease_dollars(-20)
        ease_ante(1)

        local cards_to_destroy = {}
        for i = 1, #G.hand.cards do
            cards_to_destroy[i] = G.hand.cards[i]
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
                for i = 1, #cards_to_destroy do
                    cards_to_destroy[i]:start_dissolve()
                end
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.8,
            func = function()
                if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                    local legendary_joker = SMODS.create_card({
                        set = 'Joker',
                        area = G.jokers,
                        rarity = 'Legendary',
                        legendary = true,
                        discover = true,
                        idx = nil
                    })
                    
                    legendary_joker:add_to_deck()
                    G.jokers:emplace(legendary_joker)
                    
                    legendary_joker:juice_up(0.6, 0.6)
                    play_sound('timpani', 1.1, 0.7)
                end
                return true
            end
        }))
    end
}