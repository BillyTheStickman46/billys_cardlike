SMODS.Blind {
    key = 'boxBlind',
    atlas = 'blindsAtlas',
    pos = { x = 0, y = 1 },
    mult = 2,
    boss = { min = 1, max = 99, showdown = false },
    boss_colour = HEX('000000'),
    
    config = { 
        time_limit = 30,
    },

    loc_vars = function(self)
        local current_ante = (G.GAME and G.GAME.round_resets and G.GAME.round_resets.ante) or 1
        local current_limit = self.config.time_limit + math.max(0, (current_ante - 1) * 3)
        return { vars = { current_limit } }
    end
}

local orig_update = Game.update
function Game.update(self, dt)
    orig_update(self, dt)
    
    if G.GAME and G.GAME.blind and G.GAME.blind.name and type(G.GAME.blind.name) == 'string' then
        if string.find(G.GAME.blind.name, "boxBlind") then
            
            local blind_obj = G.P_BLINDS[G.GAME.blind.name]
            local base_limit = (blind_obj and blind_obj.config and blind_obj.config.time_limit) or 45
            
            local current_ante = G.GAME.round_resets and G.GAME.round_resets.ante or 1
            local extra_time = math.max(0, (current_ante - 1) * 3)
            local new_limit = base_limit + extra_time

            if not G.GAME.box_blind_timer or (math.ceil(G.GAME.box_blind_timer) > new_limit and G.STATE == G.STATES.SELECTING_HAND) then
                G.GAME.box_blind_timer = new_limit
            end

            if G.STATE == G.STATES.SELECTING_HAND and not G.OVERLAY_MENU and not G.settings then
                G.GAME.box_blind_timer = G.GAME.box_blind_timer - dt

                local current_second = math.floor(G.GAME.box_blind_timer)
                if current_second ~= G.GAME.last_played_second and current_second >= 0 then
                    G.GAME.last_played_second = current_second
                    play_sound('btspf_tick', 1, 0.5)
                end

                if G.GAME.box_blind_timer <= 0 then
                    G.GAME.box_blind_timer = nil
                    G.STATE = G.STATES.GAME_OVER
                    G.STATE_COMPLETE = false
                end
            end
        else
            G.GAME.box_blind_timer = nil
        end
    end
end

local orig_draw = Game.draw
function Game.draw(self)
    orig_draw(self)
    
    local is_box_blind = G.GAME and G.GAME.blind and G.GAME.blind.name and type(G.GAME.blind.name) == 'string' and string.find(G.GAME.blind.name, "boxBlind")

    if is_box_blind and G.GAME.box_blind_timer and G.STATE == G.STATES.SELECTING_HAND and not G.OVERLAY_MENU and not G.settings then
        love.graphics.push()
        
        local screen_w = love.graphics.getWidth()
        local scale = math.max(1, screen_w / 1280) * 1.2
        love.graphics.scale(scale, scale)
        
        local scaled_w = screen_w / scale
        local timer_string = "TIME LEFT: " .. math.ceil(G.GAME.box_blind_timer) .. "s"
        
        local x = (scaled_w - (string.len(timer_string) * 12)) / 2
        local y = 130 
        
        love.graphics.setColor(G.GAME.box_blind_timer > 10 and {1, 1, 1, 1} or {1, 0.2, 0.2, 1})
        
        love.graphics.print(timer_string, x, y)
        love.graphics.pop()
        love.graphics.setColor(1, 1, 1, 1)
    end
end