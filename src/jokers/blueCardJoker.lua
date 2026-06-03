SMODS.Joker {
    key = 'blueCardJoker',
    atlas = 'cardsAtlas',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            chips = 0,
            chip_mod = 25
        }
    },
    rarity = 2,
    cost = 5,
    
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.chip_mod
            }
        }
    end,

    calculate = function(self, card, context)
        if context.open_booster then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.5, 0.5)
                    return true
                end
            })) 
            
            card_eval_status_text(card, 'extra', nil, nil, nil, {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            })
        end

        if context.joker_main then
            if card.ability.extra.chips > 0 then
                return {
                    message = localize{type='variable', key='a_chips', vars={card.ability.extra.chips}},
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            end
        end
    end
}