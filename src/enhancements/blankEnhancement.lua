SMODS.Enhancement {
    key = 'blankEnhancement',
    atlas = 'cardsAtlas',
    pos = { x = 1, y = 6 },
    config = {},
    in_shop = true,
    weight = 0.5, 

    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            local right_card = nil
            
            if context.scoring_hand then
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i] == card then
                        right_card = context.scoring_hand[i + 1]
                        break
                    end
                end
            end

            if right_card then
                local ret = {
                    card = card,
                }
                local has_bonus = false

                local chips = right_card:get_chip_bonus()
                if chips and chips > 0 then
                    ret.chips = chips
                    has_bonus = true
                end

                local mult = right_card:get_chip_mult()
                if mult and mult > 0 then
                    ret.mult = mult
                    has_bonus = true
                end

                local x_mult = right_card:get_chip_x_mult()
                if x_mult and x_mult > 1 then
                    ret.x_mult = x_mult
                    has_bonus = true
                end

                local p_dollars = right_card:get_p_dollars()
                if p_dollars and p_dollars > 0 then
                    ret.p_dollars = p_dollars
                    has_bonus = true
                end

                if right_card.seal == 'Gold' then
                    ret.p_dollars = (ret.p_dollars or 0) + 3
                    has_bonus = true
                end

                if has_bonus then
                    return ret
                end
            end
        end

        if context.cardarea == G.play and context.repetition then
            local right_card = nil
            
            if context.scoring_hand then
                for i = 1, #context.scoring_hand do
                    if context.scoring_hand[i] == card then
                        right_card = context.scoring_hand[i + 1]
                        break
                    end
                end
            end

            if right_card and right_card.seal == 'Red' then
                return {
                    message = 'Again!',
                    repetitions = 1,
                    card = card
                }
            end
        end
    end
}