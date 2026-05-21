SMODS.Consumable {
    key = 'lifeTarot',
    set = 'Tarot',
    atlas = 'cardsAtlas',
    pos = { x = 5, y = 4 },
    cost = 3,
    unlocked = true,
    
    config = { extra = { percent = 0, growth = 20 } },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent, card.ability.extra.growth } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and not context.individual and not context.repetition then
            if card.ability.extra.percent < 100 then
                card.ability.extra.percent = math.min(100, card.ability.extra.percent + card.ability.extra.growth)
                return {
                    message = card.ability.extra.percent .. '%',
                    colour = G.C.GREEN
                }
            end
        end
    end,

    can_use = function(self, card)
        if card.ability.extra.percent >= 100 then
            return true
        end
        
        if card.area == G.pack_cards then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                return true
            end
        end
        
        return false
    end,

    use = function(self, card, area, copier)
        if card.ability.extra.percent < 100 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    local new_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, card.config.center.key)
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                    return true
                end
            }))
            return 
        end
        
        local options = {'money', 'enhanced', 'edition', 'seal'}

        if #G.jokers.cards < G.jokers.config.card_limit then
            table.insert(options, 'jokers')
        end

        local consumable_space = G.consumeables.config.card_limit - #G.consumeables.cards
        if card.area == G.consumeables then
            consumable_space = consumable_space + 1
        end
        
        if consumable_space > 0 then
            table.insert(options, 'spectrals')
        end

        local choice = pseudorandom_element(options, pseudoseed('life_tarot_choice'))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('timpani')

                if choice == 'money' then
                    ease_dollars(15)

                elseif choice == 'jokers' then
                    for i = 1, 2 do
                        if #G.jokers.cards < G.jokers.config.card_limit then
                            local new_card = create_card('Joker', G.jokers, nil, 1, nil, nil, nil, 'life_joker')
                            new_card:add_to_deck()
                            G.jokers:emplace(new_card)
                        end
                    end

                elseif choice == 'spectrals' then
                    for i = 1, 2 do
                        if #G.consumeables.cards < G.consumeables.config.card_limit then
                            local new_card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, nil, 'life_spec')
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                        end
                    end

                elseif choice == 'enhanced' then
                    local available_enhancements = {}
                    for k, v in pairs(G.P_CENTERS) do
                        if v.set == 'Enhanced' then
                            table.insert(available_enhancements, v)
                        end
                    end

                    for i = 1, 7 do
                        local front = pseudorandom_element(G.P_CARDS, pseudoseed('life_front'))
                        local c = Card(G.play.T.x, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.c_base, {playing_card = G.playing_card})
                        local enh = pseudorandom_element(available_enhancements, pseudoseed('life_enh'))
                        c:set_ability(enh)
                        c:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, c)
                        G.deck:emplace(c)
                    end

                elseif choice == 'edition' then
                    for i = 1, 4 do
                        local front = pseudorandom_element(G.P_CARDS, pseudoseed('life_front'))
                        local c = Card(G.play.T.x, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.c_base, {playing_card = G.playing_card})
                        local edition = poll_edition('life_edition', nil, true, true)
                        c:set_edition(edition, true)
                        c:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, c)
                        G.deck:emplace(c)
                    end

                elseif choice == 'seal' then
                    local seals = {'Gold', 'Red', 'Blue', 'Purple'}
                    for i = 1, 2 do
                        local front = pseudorandom_element(G.P_CARDS, pseudoseed('life_front'))
                        local c = Card(G.play.T.x, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.c_base, {playing_card = G.playing_card})
                        local seal = pseudorandom_element(seals, pseudoseed('life_seal'))
                        c:set_seal(seal)
                        c:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, c)
                        G.deck:emplace(c)
                    end
                end
                
                return true
            end
        }))
    end
}