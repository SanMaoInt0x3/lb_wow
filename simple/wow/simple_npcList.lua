local games = EmunGames()
lbLog('找到 ' .. #games .. ' 个游戏窗口')
if #games > 0 then 
    local pid = games[1].pid
    lbLog('PID = '.. games[1].pid .. ' name = ' .. games[1].name .. ' 服务器 = ' .. games[1].serverName )
    if pid then
        lbLog('开始绑定PID ' .. pid)
        local obj = newInstance(pid)
        if obj then
            lbLog('绑定成功 ..' ..  tostring(obj))
            local npcs = obj:GetNpcList(false)
            lbLog('遍历到 ' ..  #npcs .. ' 个npc')
            if #npcs > 0 then
                for index, value in ipairs(npcs) do
                    lbLog('[' .. index .. ']' .. value.name)
                end
            end
            obj:Destroy()
        end
    end
end