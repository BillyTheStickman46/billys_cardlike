SMODS.Consumable {
    key = 'chaosTarot',
    set = 'Tarot',
    atlas = 'cardsAtlas',
    pos = { x = 1, y = 4 },
    cost = 3,
    unlocked = true,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
        info_queue[#info_queue + 1] = G.P_CENTERS.m_btspf_hybridEnhancement
        return { vars = {} }
    end,
    
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= 2 then
            return true
        end
        return false
    end,

    use = function(self, card, area, copier)
        local targets = {}
        for i = 1, #G.hand.highlighted do
            targets[i] = G.hand.highlighted[i]
        end

        for i = 1, #targets do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = (i == 1) and 0 or 0.2,
                func = function()
                    targets[i]:flip()
                    play_sound('tarot2', 1 + (i * 0.05), 0.6)
                    return true
                end
            }))
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                local bonus_center = G.P_CENTERS.m_bonus
                local mult_center = G.P_CENTERS.m_mult
                local hybrid_center = G.P_CENTERS.m_btspf_hybridEnhancement

                for i = 1, #targets do
                    local target_card = targets[i]
                    
                    if target_card.config.center == bonus_center or target_card.config.center == mult_center then
                        if hybrid_center then
                            target_card:set_ability(hybrid_center)
                        end
                    else
                        if pseudorandom('chaos_tarot_' .. i) > 0.5 then
                            target_card:set_ability(bonus_center)
                        else
                            target_card:set_ability(mult_center)
                        end
                    end
                end
                return true
            end
        }))

        for i = 1, #targets do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = (i == 1) and 0.7 or 0.2,
                func = function()
                    targets[i]:flip()
                    play_sound('tarot2', 1.2 + (i * 0.05), 0.6)
                    return true
                end
            }))
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.3,
            func = function()
                for i = 1, #targets do
                    targets[i]:juice_up(0.3, 0.3)
                end
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}