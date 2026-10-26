-- ========================================================
-- AUTO PNB GENTA HAX - by Elgato91169
-- ========================================================

place_id = 5640  -- Item ID to place (Example: 5640 for Magplant Remote)
break_id = 340   -- Block ID to break (Example: 340 for Chandelier)

XCoords = {1, 2} -- Block position (1 and 2 blocks to the right). Use {-1, -2} for left
YCoords = 0      -- 0 = same level, -1 = above player, 1 = below player

-- ========================================================
-- DO NOT CHANGE THE CODE BELOW (CORE SYSTEM)
-- ========================================================

custom_seed = 12345
function randDelay(min, max)
    custom_seed = (custom_seed * 1103515245 + 12345) % 2147483648
    local range = (max - min) + 1
    return min + (custom_seed % range)
end

function Place(x, y, px, py, netid, swingState, idleState)
    sendPacketRaw(false, {
        type = 0, value = break_id, punchx = x, punchy = y,
        x = px, y = py, state = swingState, netid = netid
    })
    
    requestTileChange(x, y, place_id)
    sleep(randDelay(100, 130)) 
    
    sendPacketRaw(false, {
        type = 0, value = break_id, punchx = x, punchy = y,
        x = px, y = py, state = idleState, netid = netid
    })
    sleep(randDelay(60, 80)) 
end

function Hit(x, y, px, py, netid, swingState, idleState)
    sendPacketRaw(false, {
        type = 0, value = 18, punchx = x, punchy = y,
        x = px, y = py, state = swingState, netid = netid
    })
    
    requestTileChange(x, y, 18)
    sleep(randDelay(100, 130)) 
    
    sendPacketRaw(false, {
        type = 0, value = 18, punchx = x, punchy = y,
        x = px, y = py, state = idleState, netid = netid
    })
    sleep(randDelay(50, 70)) 
end

function pnb()
    local player = getLocal()
    if player == nil then return end

    local px = player.pos.x
    local py = player.pos.y
    local netid = player.netId
    local baseX = px // 32
    local baseY = py // 32

    local placed_any = false
    for i = 1, #XCoords do
        local tx = baseX + XCoords[i]
        local ty = baseY + YCoords
        local tile = checkTile(tx, ty)

        if tile ~= nil and tile.fg == 0 then
            local isLeft = (baseX > tx)
            local swingState = isLeft and 2608 or 2592
            local idleState = isLeft and 48 or 32
            
            Place(tx, ty, px, py, netid, swingState, idleState)
            placed_any = true
        end
    end

    if placed_any then
        sleep(randDelay(120, 160)) 
    end

    for i = 1, #XCoords do
        local tx = baseX + XCoords[i]
        local ty = baseY + YCoords
        local tile = checkTile(tx, ty)

        if tile ~= nil and tile.fg ~= 0 then
            local isLeft = (baseX > tx)
            local swingState = isLeft and 2608 or 2592
            local idleState = isLeft and 48 or 32
            
            local tries = 0
            
            while tile ~= nil and tile.fg ~= 0 and tries < 15 do
                Hit(tx, ty, px, py, netid, swingState, idleState)
                
                tries = tries + 1
                tile = checkTile(tx, ty)
            end
        end
    end
end

while true do
    pnb()
    sleep(randDelay(120, 160)) 
end