SMODS.Consumable {
    key = 'riftTarot',
    set = 'Tarot',
    atlas = 'cardsAtlas',
    pos = { x = 4, y = 4 },
    cost = 3,
    unlocked = true,
    
    can_use = function(self, card)
        if #G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    local new_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'riftTarot')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                end
                return true
            end
        }))
        delay(0.6)
    end
}