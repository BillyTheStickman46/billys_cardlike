SMODS.Consumable {
    key = 'adjustmentTarot',
    set = 'Tarot',
    atlas = 'cardsAtlas',
    pos = { x = 3, y = 4 },
    cost = 3,
    unlocked = true,
    
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted == 1 then
            local target_card = G.hand.highlighted[1]
            if target_card.config.center.set == 'Enhanced' then
                local current_key = target_card.config.center.key
                if current_key == 'm_bonus' or current_key == 'm_mult' or current_key == 'm_steel' or 
                   current_key == 'm_gold' or current_key == 'm_lucky' or current_key == 'm_glass' or 
                   current_key == 'm_wild' or current_key == 'm_stone' then
                    return true
                end
            end
        end
        return false
    end,

    use = function(self, card, area, copier)
        local target_card = G.hand.highlighted[1]

        local upgrade_map = {
            m_bonus = 'hybridEnhancement',
            m_mult = 'hybridEnhancement',
            m_steel = 'platinumEnhancement',
            m_gold = 'rubyEnhancement',
            m_lucky = 'bitteredEnhancement',
            m_glass = 'temperedGlassEnhancement',
            m_wild = 'unsuitedEnhancement',
            m_stone = 'magmaEnhancement'
        }

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                target_card:flip()
                play_sound('tarot2', 1.0, 0.6)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                local current_key = target_card.config.center.key
                local target_enh_name = upgrade_map[current_key]
                
                if target_enh_name then
                    local new_center = nil
                    
                    if G.P_CENTERS[target_enh_name] then
                        new_center = G.P_CENTERS[target_enh_name]
                    else
                        for k, v in pairs(G.P_CENTERS) do
                            if k:find(target_enh_name .. "$") then
                                new_center = v
                                break
                            end
                        end
                    end

                    if new_center then
                        target_card:set_ability(new_center)
                    end
                end
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.5,
            func = function()
                target_card:flip()
                play_sound('tarot2', 1.1, 0.6)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                target_card:juice_up(0.3, 0.3)
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}