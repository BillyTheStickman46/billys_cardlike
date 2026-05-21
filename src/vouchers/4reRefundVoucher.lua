SMODS.Voucher {
    key = 'reRefundVoucher',
    atlas = 'cardsAtlas',
    pos = { x = 3, y = 3 },
    cost = 10,
    requires = {'v_refundVoucher'},
}

local function has_rerefund_voucher()
    if not G.GAME or not G.GAME.used_vouchers then return false end
    for k, v in pairs(G.GAME.used_vouchers) do
        if type(k) == 'string' and k:match('reRefundVoucher$') then
            return true
        end
    end
    return false
end

local original_skip_blind = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    if has_rerefund_voucher() then 
        
        local blind_type = G.GAME.blind_on_deck or 'Small'
        local payout = 0
        
        if G.GAME.round_resets.blind_choices and G.GAME.round_resets.blind_choices[blind_type] then
            local blind_key = G.GAME.round_resets.blind_choices[blind_type]
            if G.P_BLINDS[blind_key] then
                payout = G.P_BLINDS[blind_key].dollars
            end
        end
        
        if payout == 0 then
            if blind_type == 'Small' then payout = 3
            elseif blind_type == 'Big' then payout = 4
            elseif blind_type == 'Boss' then payout = 5
            end
        end

        local no_reward = false
        if G.GAME.modifiers.no_blind_reward then
            if type(G.GAME.modifiers.no_blind_reward) == 'table' then
                no_reward = G.GAME.modifiers.no_blind_reward[blind_type]
            else
                no_reward = (blind_type == 'Small')
            end
        end
        
        if no_reward then 
            payout = 0 
        end

        if payout > 0 then
            ease_dollars(payout)
        end
    end

    original_skip_blind(e)
end