-- 综合功能的写法
local obj = newInstance(7036)
if obj then
    -- 遍历矿草
    local scenes =  obj:GetSceneList()
    lbLog(' 矿草数量 ' .. #scenes)
    if #scenes > 0 then
        for index, value in ipairs(scenes) do
            lbLog('[' .. index .. ']' .. value.name)
        end
    end
    -- 人物信息
    local hp, maxHp, mp, maxMp = obj:GetPlayerHealth()
    lbLog(' 人物血蓝 ' .. hp .. '/' .. maxHp .. ' | ' .. mp .. '/' .. maxMp)
    local x,y,z = obj:GetPlayerLocal()
    lbLog(' 坐标 ' .. x .. ',' .. y .. ',' .. z)
    -- 宏命令
    obj:RunMacro('/y 我是大傻逼')
    -- 人物移动
    obj:ClickToMove(-615.21,-4257.04,38.95)
    -- 左键点击
    obj:LeftClick(-615.21,-4257.04,38.95)
    -- 遍历玩家
    local otherPlayers = obj:GetOtherPlayerList()
    lbLog(' 玩家数量' .. #otherPlayers)
    if #otherPlayers > 0 then
        for index, value in ipairs(otherPlayers) do
            lbLog('[' .. index .. ']' .. value.name)
        end
    end
    -- 释放对象
    obj:Destroy()
end
