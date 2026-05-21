SMODS.Joker {
    key = 'recycleBinJoker',
    atlas = 'cardsAtlas',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            requirement = 15,
            current = 0,
            money_reward = 4,
        }
    },
    rarity = 3,
    cost = 6,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.requirement,
                card.ability.extra.current,
                card.ability.extra.money_reward
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard and not context.blueprint then
            card.ability.extra.current = card.ability.extra.current + 1

            if card.ability.extra.current >= card.ability.extra.requirement then
                card.ability.extra.current = 0

                local roll = pseudorandom('recycle_bin_roll', 1, 4)

                if roll == 4 then
                    ease_dollars(card.ability.extra.money_reward)
                    return {
                        message = '+$' .. card.ability.extra.money_reward,
                        colour = G.C.MONEY,
                        card = card
                    }
                else
                    if #G.consumeables.cards < G.consumeables.config.card_limit then
                        local pool_key = ''
                        local reward_msg = ''

                        if roll == 1 then
                            pool_key = 'Planet'
                            reward_msg = 'Planet!'
                        elseif roll == 2 then
                            pool_key = 'Tarot'
                            reward_msg = 'Tarot!'
                        elseif roll == 3 then
                            pool_key = 'Spectral'
                            reward_msg = 'Spectral!'
                        end

                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.1,
                            func = function()
                                play_sound('timpani')
                                local spawned_card = create_card(pool_key, G.consumeables, nil, nil, nil, nil, nil, 'recycle')
                                spawned_card:add_to_deck()
                                G.consumeables:emplace(spawned_card)
                                card:juice_up(0.3, 0.3)
                                return true
                            end
                        }))

                        return {
                            message = 'Free ' .. reward_msg,
                            colour = G.C.SECONDARY_SET.Tarot
                        }
                    else
                        return {
                            message = 'Full!',
                            colour = G.C.FILTER
                        }
                    end
                end
            end
        end
    end
}