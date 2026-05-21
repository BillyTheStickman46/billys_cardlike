SMODS.Joker {
    key = 'hardModeJoker',
    atlas = 'cardsAtlas',
    pos = { x = 2, y = 0 },
    config = {
        extra = {
            reduction = 0.75,
            multiplier = 1.5,
            payout = 0,
        }
    },
    rarity = 2,
    cost = 5,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.reduction,
                card.ability.extra.multiplier
            }
        }
    end,
    
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.payout > 0 then
            local bonus = card.ability.extra.payout
            card.ability.extra.payout = 0 
            return bonus
        end
        return 0
    end,

    calculate = function (self, card, context)
        if context.final_scoring_step and not context.blueprint then
            mult = mod_mult(mult * card.ability.extra.reduction)
            hand_chips = mod_chips(hand_chips * card.ability.extra.reduction)
            
            return {
                message = 'Hard Mode!',
                colour = G.C.RED
            }
        end

        if context.end_of_round and not context.blueprint and not context.repetition then
            local blind_amt = G.GAME.blind and G.GAME.blind.dollars or 0
            local hands_amt = (G.GAME.current_round.hands_left or 0) * 1  -- $1 per remaining hand
            local interest_amt = 0
            if not G.GAME.modifiers.no_interest then
                interest_amt = math.min(math.floor(G.GAME.dollars / 5), (G.GAME.interest_cap or 25) / 5)
            end

            local discards_amt = 0
            if G.GAME.modifiers.no_interest then 
                discards_amt = (G.GAME.current_round.discards_left or 0) * 1
            end
            
            local total_base_money = blind_amt + hands_amt + interest_amt + discards_amt

            local extra_payout = math.floor(total_base_money * (card.ability.extra.multiplier - 1) + 0.5)

            if extra_payout > 0 then
                card.ability.extra.payout = extra_payout
            end
        end
    end,
}