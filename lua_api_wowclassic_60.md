# 魔兽世界60级经典服 lua 接口文档

# 公共方法
- 打印调试日志
```
lbLog(string log)
```
- 线程休眠
```lua
sleep(int msec)
-- 参数 int msec(int)： 休眠时间，单位毫秒
```
- 计算2个坐标的之间的距离
```lua
local dis = CalDistance(number x1, numerb y1, number x2, number y2)
-- 说明：计算2个坐标的之间的距离
-- 参数：x1,y1 第一个坐标
-- 参数: x2,y2 第二个坐标
-- 返回值(number)： 第一个坐标和第二个坐标的距离,一般用于计算技能释放距离
```

- 计算朝向角度
```lua
local dir = CalDircetion(number nx, numerb ny, number px, number py)
-- 说明：计算朝向角度
-- 参数：nx,ny 第一个坐标
-- 参数: px,py 第二个坐标
-- 返回值(number)： 我们可以这样假设：第一个坐标是怪物的坐标，第二个坐标是角色的坐标，那么返回值得到的就是角色面向怪物的角度
```

# 游戏对象类
- 创建游戏对象
```lua
local obj = newInstance(pid)
-- 参数 pid(int)： 游戏进程pid
-- 返回值（obj）：返回绑定一个游戏进程窗口的对象，里面封装了丰富的方法、游戏数据
```

- 销毁游戏对象
```lua
local obj:Destroy()
-- 说明：调用此函数会释放游戏进程绑定，释放对象
```


# 游戏对象类内置函数
- 获取当前对象绑定的pid
```lua
local pid = obj:getId()
-- 返回值（int）：当前对象绑定的游戏进程id
```

- 人物移动
```lua
obj:ClickToMove(x,y,z)
-- 参数 x,y,z(float): 人物移动坐标 
-- 无返回值
```

- 获取角色周围地面对象列表
```lua
local scenelist = obj:GetSceneList()
-- 返回值（list<table>）：返回玩家附近的所有地面物品对象列表，属性如下：
-- table['obj'](number): 地面物品对象在内存中的地址
-- table['id'](int): 地面物品对象的id
-- table['name'](string): 地面物品对象的名字
-- table['x'](number): 地面物品对象当前x坐标
-- table['y'](number): 地面物品对象当前y坐标
-- table['z'](number): 地面物品对象当前z坐标
```

- 获取其他玩家
```lua
local otherPlayers = obj:GetOtherPlayerList()
-- 返回值（list<table>）：返回附近的所有玩家信息，属性如下：
-- table['obj'](number): 其他玩家对象在内存中的地址
-- table['name'](string): 其他玩家对象的名字
-- table['hp'](int): 其他玩家对象当前血量
-- table['maxhp'](int): 其他玩家对象最大血量
-- table['mp'](int): 其他玩家对象当前蓝量
-- table['maxmp'](int): 其他玩家对象最大蓝量
```

- 获取当前UI显示的控件列表
```lua
local controllist = obj:GetControlList()
-- 返回值（list<table>）：返回前UI显示的控件列表，属性如下：
-- table['obj'](number): 控件对象在内存中的地址
-- table['id'](int): 控件ID
-- table['name'](string): 控件名称（这是在游戏UI框架内的名称，不是我们看到的名称）
-- table['title'](string): 控件标题（这是我们在游戏内看到的控件名字，例如：接受、确定 等）
```

- 左键点击控件
```lua
obj:LeftClickControl(int p)
-- 说明：点击游戏内控件
-- 参数 p: 控件的对象地址
-- 无返回值
```

- 键盘按键
```lua
obj:PressKeyboard(int key, int time)
-- 参数 key : 按键代码，参考：https://blog.csdn.net/weixin_38061311/article/details/99938426
-- 参数 time： 按下多久（毫秒）
-- 无返回值
```

- 和目标交互
```lua
obj:PlayerInteraction(int p)
-- 说明：和目标交互
-- 参数 p: 目标的对象地址
-- 无返回值
```

- 左键点击地面
```lua
obj:LeftClick(number x, number y)
-- 说明：左键点击地面,类似法师施放暴风雪的位置
```

- 运行宏命令
```lua
obj:RunMacro(string macro)
-- 说明：运行宏命令 不适应太长，如果很长请分开多个语句运行
```

- 角色血蓝信息
```lua
local hp,maxhp,mp,maxmp = obj:GetPlayerHealth()
-- 说明：角色血蓝信息
-- 返回值 hp(int) 当前血量 maxhp(int) 最大血量 mp(int) 蓝量(集中值、怒气、能量) maxmp(int) 最大蓝量
```

- 角色坐标
```lua
local x,y,z = obj:GetPlayerLocal()
-- 说明：角色当前所在坐标信息
-- 返回值 x(number) y(number) z(number) 
```
