SMODS.Blind {
    key = 'omegaBlind',
    atlas = 'blindsAtlas',
    pos = { x = 0, y = 0 },
    mult = 1.5,
    boss = { min = 1, max = 10 },
    boss_colour = HEX('7A7A7A'),

    press_play = function(self)
        if G.GAME and G.GAME.blind and not G.GAME.blind.disabled then
            -- We set a custom variable to remember that a hand was just submitted
            G.GAME.blind.omega_hand_played = true
        end
    end,

    drawn_to_hand = function(self)
        if G.GAME and G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.omega_hand_played then
            G.GAME.blind.chips = G.GAME.blind.chips * 1.25
            
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            
            G.GAME.blind:juice_up()

            G.GAME.blind.omega_hand_played = false
        end
    end
}