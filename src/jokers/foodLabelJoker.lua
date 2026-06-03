SMODS.Joker {
    key = 'foodLabelJoker',
    atlas = 'cardsAtlas',
    pos = { x = 4, y = 0 },
    config = {
        extra = {
            x_chips_per = 0.075,
            current_x_chips = 1
        }
    },
    rarity = 3,
    cost = 6,
    
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_chips_per,
                card.ability.extra.current_x_chips
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            card.processed_cards = {}
        end

        if context.individual and context.cardarea == G.play then
            local scoring_card = context.other_card
            
            if not card.processed_cards then card.processed_cards = {} end

            if card.processed_cards[scoring_card] then
                return
            end

            local count = 0

            if scoring_card.config.center ~= G.P_CENTERS.c_base then
                count = count + 1
            end

            if scoring_card.seal then
                count = count + 1
            end

            if scoring_card.edition then
                count = count + 1
            end

            if count > 0 and not context.blueprint then
                card.processed_cards[scoring_card] = true

                card.ability.extra.current_x_chips = card.ability.extra.current_x_chips + (count * card.ability.extra.x_chips_per)
                
                card_eval_status_text(card, 'extra', nil, nil, nil, {
                    message = 'Upgrade!',
                })
            end
        end

        if context.joker_main then
            return {
                x_chips = card.ability.extra.current_x_chips,
                card = context.blueprint_card or card
            }
        end
    end
}