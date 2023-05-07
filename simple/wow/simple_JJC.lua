local games = EmunGames()
lbLog('找到 ' .. #games .. ' 个游戏窗口')
if #games > 0 then 
    local pid = games[1].pid
    lbLog('PID = '.. games[1].pid .. ' name = ' .. games[1].name .. ' 服务器 = ' .. games[1].serverName )
    if pid then
        lbLog('开始绑定PID ' .. pid)
        local obj = newInstance(pid)
        if obj then
            local arenas = obj:GetArenaList()
            lbLog('战场队列数量 ：' .. #arenas)
            for index, value in ipairs(arenas) do
                lbLog('队列ID = ' .. value)
            end
            local time = obj:GetArenaStartTime()
            lbLog('竞技场余剩开始时间 = ' .. time .. '毫秒')
            obj:Destroy()
        end
    end
end