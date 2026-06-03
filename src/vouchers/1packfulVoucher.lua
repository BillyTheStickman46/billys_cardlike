SMODS.Voucher {
    key = 'packfulVoucher',
    atlas = 'cardsAtlas',
    pos = { x = 0, y = 3 },
    cost = 10,
    plus_pool = 'v_overpackedVoucher',
    config = { extra = { size_increase = 1 } },
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.size_increase } }
    end,

    redeem = function(self)
        G.GAME.modifiers.booster_size_mod = (G.GAME.modifiers.booster_size_mod or 0) + self.config.extra.size_increase
    end
}