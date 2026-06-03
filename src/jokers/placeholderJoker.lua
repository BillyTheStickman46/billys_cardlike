SMODS.Joker {
    key = 'placeholderJoker',
    atlas = 'cardsAtlas',
    pos = { x = 4, y = 1 },
    config = {
        extra = {
            joker_slots = 1
        }
    },
    rarity = 1,
    cost = 4,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extra.joker_slots
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slots
        card.sell_cost = card.cost
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slots
    end
}