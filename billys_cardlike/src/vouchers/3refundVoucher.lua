SMODS.Voucher({
    key = 'refundVoucher',
    config = {extra = {}},
    pos = {x = 2, y = 3},
    atlas = 'cardsAtlas',
    cost = 10,
    plus_pool = 'v_reRefundVoucher',
})

local function has_refund_voucher()
    if not G.GAME or not G.GAME.used_vouchers then return false end
    for k, v in pairs(G.GAME.used_vouchers) do
        if type(k) == 'string' and k:match('refundVoucher$') then
            return true
        end
    end
    return false
end

local original_card_open = Card.open
function Card.open(self)
    if self.ability and self.ability.set == 'Booster' then
        local choose_amt = self.ability.choose or (self.config and self.config.center and self.config.center.config and self.config.center.config.choose) or 1
        
        local original_cost = 4 
        if self.config and self.config.center and self.config.center.cost then
            original_cost = self.config.center.cost
        end
        
        if G.GAME.discount_percent then
            original_cost = math.max(0, math.floor(original_cost * (1 - (G.GAME.discount_percent / 100))))
        end

        G.GAME.btspf_current_pack = {
            cost = original_cost,
            choose = choose_amt
        }
    end
    return original_card_open(self)
end

local original_skip_booster = G.FUNCS.skip_booster
G.FUNCS.skip_booster = function(e)
    if has_refund_voucher() and G.GAME.btspf_current_pack then
        local pack = G.GAME.btspf_current_pack
        local refund = 0
        local remaining = G.GAME.pack_choices or 1 

        if remaining == pack.choose then
            refund = pack.cost
        elseif pack.choose > 1 and remaining < pack.choose and remaining > 0 then
            refund = math.floor((pack.cost * (remaining / pack.choose)) + 0.5)
        end

        if refund > 0 then
            ease_dollars(refund)
        end
    end

    if G.GAME then
        G.GAME.btspf_current_pack = nil
    end

    original_skip_booster(e)
end