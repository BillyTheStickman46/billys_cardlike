return {
    descriptions = {
        Joker = {
            j_btspf_crazyWizardJoker = {
                name = 'Crazy Wizard',
                text = {
                    'At the start of round and every hand:',
                    '{C:green}1 in #2#{} chance to destroy a card in hand',
                    '{C:green}1 in #3#{} chance to add {C:dark_edition}Foil, {C:dark_edition}Holographic{}',
                    'or {C:dark_edition}Polychrome{} edition to a random card'
                }
            },
            j_btspf_hardModeJoker = {
                name = 'Hard Mode',
                text = {
                    '{X:mult,C:white}x#1#{} the total {C:chips}Chips{} and {C:mult}Mult{}',
                    'of each hand, but {X:money,C:white}x#2#{} total money',
                    'gained at the end of each round'
                }
            },
            j_btspf_placeholderJoker = {
                name = 'Placeholder',
                text = {
                    '{C:dark_edition}+#1#{} Joker slot',
                    'Selling price is the {C:money}same',
                    'as purchasing price'
                }
            },
            j_btspf_recycleBinJoker = {
                name = 'Recycle Bin',
                text = {
                    'Gives {C:money}4${}, {C:planet}Planet{} card, {C:tarot}Tarot{} card or',
                    '{C:spectral}Spectral{} card every 15 cards discarded',
                    '{C:inactive}(Currently{} {C:attention}#2#{} {C:inactive}cards discarded){}'
                }
            },
            j_btspf_blueCardJoker = {
                name = 'Blue Card',
                text = {
                    'This Joker gains {C:chips}+#2#{} extra chips',
                    'when any {C:attention}Booster Pack{} is opened',
                    '{C:inactive}(Currently{} {C:chips}+#1#{} {C:inactive}extra chips){}'
                }
            },
            j_btspf_foodLabelJoker = {
                name = 'Food Label',
                text = {
                    'This Joker gains {X:chips,C:white}X#1#{} Chips for each',
                    '{C:attention}Enhancement{}, {C:attention}Seal{} or {C:attention}Edition{} of a scored card',
                    '{C:inactive}(Must have{} {C:attention}Enhancement{}, {C:attention}Seal{} or {C:attention}Edition{} {C:inactive})',
                    '{C:inactive}(Currently{} {X:chips,C:white}X#2#{}{C:inactive}){}'
                }
            },
        },
        Tarot = {
            c_btspf_balanceTarot = {
                name = 'Balance',
                text = {
                    'Sets rank of {C:attention}2{} selected',
                    'cards as their avarage rank'
                }
            },
            c_btspf_chaosTarot = {
                name = 'Chaos',
                text = {
                    'Enhances {C:attention}2{} selected cards to {C:attention}Bonus Cards{}',
                    'or {C:attention}Mult Cards{}. If the card is already {C:attention}Bonus Cards{}',
                    'or {C:attention}Mult Cards{}, enhances to {C:attention}Hybrid Card{}'
                }
            },
            c_btspf_blankTarot = {
                name = '?',
                text = {
                    'Enhances {C:attention}1{} selected cards to {C:attention}Blank Card{}',
                }
            },
            c_btspf_adjustmentTarot = {
                name = 'Adjustment',
                text = {
                    'Upgrades 1 selected {C:attention}Enhanced{} card',
                    '{C:inactive}(Must have{} {C:attention}vanilla{} {C:inactive}enhancement){}'
                }
            },
            c_btspf_riftTarot = {
                name = 'The Rift',
                text = {
                    'Creates {C:attention}1{} random {C:spectral}Spectral{} card',
                    '{C:inactive}(Must have room){}'
                }
            },
            c_btspf_lifeTarot = {
                name = 'Life',
                text = {
                    "Grows {C:attention}#2#%{} at the end of each round.",
                    "{C:inactive}(Current growth:{} {C:attention}#1#%{}{C:inactive}){}",
                    "{C:inactive,s:0.8}(At 100% usage,",
                    "{C:inactive,s:0.8}grants a random reward)"
                }
            }
        },
        Enhanced = {
            m_btspf_hybridEnhancement = {
                name = 'Hybrid Card',
                text = {
                    '{C:chips}+#1#{} extra chips',
                    '{C:mult}+#2#{} Mult'
                }
            },
            m_btspf_blankEnhancement = {
                name = 'Blank Card',
                text = {
                    'Copies ability of {C:attention}card{} to the right'
                }
            },
            m_btspf_platinumEnhancement = {
                name = "Platinum Card",
                text = {
                    "{X:mult,C:white}X#1#{} Mult while this",
                    "card stays in hand"
                }
            },
            m_btspf_bitteredEnhancement = {
                name = "Bittered Card",
                text = {
                    '{C:green}1 in #2#{} chance for {C:mult}+#3#{} Mult',
                    '{C:green}1 in #4#{} chance to win {C:money}$#4#{}',
                }
            },
            m_btspf_unsuitedEnhancement = {
                name = "Unsuited Card",
                text = {
                    "Does not count as any suit"
                }
            },
            m_btspf_temperedGlassEnhancement = {
                name = "Tempered Glass Card",
                text = {
                    '{X:mult,C:white}X#1#{} Mult',
                    '{C:green}1 in #3#{} chance to destroy card'
                }
            },
            m_btspf_rubyEnhancement = {
                name = "Ruby Card",
                text = {
                    '{C:money}$#1#{} if this card is held',
                    'in hand at end of round',
                }
            },
            m_btspf_magmaEnhancement = {
                name = "Magma Card",
                text = {
                    "{C:chips}+#1#{} chips and {C:mult}+#2#{} Mult",
                    "no rank or suit",
                }
            }
        },
        Spectral = {
            c_btspf_altarSpectral = {
                name = 'Altar',
                text = {
                    '{C:red}Destroys{} every card in hand',
                    '{C:money}-20${}, {C:red}+1{} Ante',
                    'Gives a free {C:legendary}Legendary{} Joker',
                    '{C:inactive}(Must have room, money and cards){}'
                }
            },
        },
        Blind = {
            bl_btspf_omegaBlind = {
                name = "The Omega",
                text = {
                    'Extra small blind',
                    "{X:red,C:white}X1.25{} required chips",
                    "after every hand played",
                }
            },
            bl_btspf_boxBlind = {
                name = 'The Box',
                text = {
                    'Must defeat the {C:attention}Blind{}',
                    'within {C:attention}#1#{} seconds',
                }
            }
        },
        Voucher = {
            v_btspf_packfulVoucher = {
                name = 'Packful',
                text = {
                    "Permanently increase",
                    "{C:attention}Booster Pack{}'s",
                    "size by {C:attention}#1#{}"
                }
            },
            v_btspf_overpackedVoucher = {
                name = 'Overpacked',
                text = {
                    "Permanently increase",
                    "{C:attention}Booster Pack{}'s",
                    "size by an additional {C:attention}#1#{}"
                }
            },
            v_btspf_refundVoucher = {
                name = 'Refund',
                text = {
                    "Skipping a {C:attention}Booster",
                    "Pack{} refunds its",
                    "purchase value {C:attention}proportionally{}"
                }
            },
            v_btspf_reRefundVoucher = {
                name = 'Re-Refund',
                text = {
                    "Skipping a {C:attention}Small Blind{} or",
                    "{C:attention}Big Blind{} refunds its reward",
                }
            },
        }
    }
}