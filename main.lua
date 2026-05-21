SMODS.Sound:register_global()

SMODS.Atlas { key = 'cardsAtlas', path = 'cards.png', px = 71, py = 95 }
SMODS.Atlas { key = 'blindsAtlas', path = 'blinds.png', px = 34, py = 34, atlas_table = 'ASSET_ATLAS'}

local folders = {"jokers", "tarots", "enhancements", "spectrals", "blinds", "vouchers"}
for _, folder in ipairs(folders) do
    local files = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/" .. folder)
    for _, file in ipairs(files) do
        assert(SMODS.load_file("src/" .. folder .. "/" .. file))()
    end
end