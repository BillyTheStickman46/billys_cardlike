SMODS.Joker {
    key = 'crazyWizardJoker',
    atlas = 'cardsAtlas',
    pos = { x = 3, y = 0 },
    config = {
        extra = {
            destroy_odds = 4,
            enchant_odds = 8,
        }
    },
    rarity = 3,
    cost = 7,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        return {
            vars = {
                G.GAME and G.GAME.probabilities.normal or 1,
                card.ability.extra.destroy_odds,
                card.ability.extra.enchant_odds
            }
        }
    end,

    calculate = function (self, card, context)
        local perform_action = false

        if context.first_hand_drawn and not context.blueprint then
            perform_action = true
        end

        if context.after and not context.blueprint then
            perform_action = true
        end

        if perform_action then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.7, 
                func = function()
                    local destroyed_a_card = false

                    if G.hand.cards and #G.hand.cards > 0 then
                        if pseudorandom('crazy_enchanter_destroy_check') < G.GAME.probabilities.normal / card.ability.extra.destroy_odds then
                            local destroyed_card = pseudorandom_element(G.hand.cards, pseudoseed('crazy_enchanter_destroy'))
                            
                            destroyed_card.removed = true
                            G.deck.config.card_limit = G.deck.config.card_limit - 1
                            
                            if not G.GAME.demolished then 
                                G.GAME.demolished = {} 
                            end
                            table.insert(G.GAME.demolished, destroyed_card)
                            
                            G.hand:remove_card(destroyed_card)
                            destroyed_card:remove()
                            
                            destroyed_a_card = true
                            
                            card:juice_up(0.8, 0.8) 
                        end
                    end

                    if G.hand.cards and #G.hand.cards > 0 and destroyed_a_card then
                        if pseudorandom('crazy_enchanter_edition') < G.GAME.probabilities.normal / card.ability.extra.enchant_odds then
                            local target_card = pseudorandom_element(G.hand.cards, pseudoseed('crazy_enchanter_target'))
                            local editions = {'foil', 'holo', 'polychrome'}
                            local chosen_edition = pseudorandom_element(editions, pseudoseed('crazy_enchanter_edition_type'))
                            
                            target_card:set_edition({[chosen_edition] = true}, true)
                        end
                    end
                    
                    return true
                end
            }))
        end
    end,
}