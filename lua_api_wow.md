# 魔兽世界正式服 lua 接口文档
# 公共方法
- 枚举游戏进程
```lua
local games = EmunGames()
-- 说明：此函数只会枚举出已登录角色且未被newInstance()绑定的进程
-- 返回值 list(table)： 游戏窗口信息，属性如下：
-- games['pid'](int): 游戏进程id
-- games['name'](string): 登录的角色名字
-- games['serverName'](string): 登录的服务器名字
```
- 强制卸载、解绑游戏进程
```lua
UnloadGameForce(pid)
-- 说明，此函数会强制解绑已经被newInstance()绑定的进程，但是newInstance()生成的对象未被释放，需要手动调用obj:destroy()才能彻底释放
-- 参数pid(pid) 游戏进程pid
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

- 设置地图包路径
```lua
local set = SetNavigationMmapFolder(string mmapFolder)
-- 说明：设置地图包文件所在的路径，只需要定位到文件夹就行，文件夹里面的内容应该是 .mmap文件和.mmtile文件。只有正确设定好这个地图包的文件位置生成导航坐标才能正确使用。
-- 参数：mmapFolder 地图包文件夹位置,注意! '\' 应该用 '\\'才能转义成功，如: "E:\\mmaps"
-- 返回值： 是否设置成功
```

- 生成导航路径坐标列表
```lua
local poinList = GetNavigationPath(int mapId, number startX, number startY, number startZ, number endX, number endY, number endZ)
-- 说明：生成导航坐标：生一系列从起点导航到终点的坐标列表。注意！第一次生成需要加载地图包到内存，所以第一次会比较耗时，以后的每一次都很快。
-- 参数：mapId 导航大陆地图ID，可通过 obj:GetLocalId() 获取
-- 参数：startX, tartY,startZ 起点坐标
-- endX, endY,endZ 终点坐标
-- 返回值(nil 生成失败)： list<table> 坐标列表，属性如下：
-- table['x'] : x坐标
-- table['y'] : y坐标
-- table['z'] : z坐标
-- 一个正确生成导航路径的列子：
local set = SetNavigationMmapFolder("E:\\mmaps")
local poinList = GetNavigationPath(1, 2119.60,-4667.21,49.05, 2055.24,-4707.58,30.15)
for index, value in ipairs(poinList) do
    print(value['x'] .. "," .. value['y'] .. "," .. value['z'])
end
-- 上面执行的结果：
-- 2119.6000976562,-4667.2099609375,49.337154388428
-- 2084.2666015625,-4706.1333007812,38.403823852539
-- 2069.3332519531,-4714.6665039062,33.870491027832
-- 2055.2399902344,-4707.580078125,30.439622879028
-- 依照上面的结果一个个点的移动就可以导航到目的地
```

# 游戏对象类
- 创建游戏对象
```lua
local obj = newInstance(pid)
-- 参数 pid(int)： 游戏进程pid
-- 返回值（obj）：返回绑定一个游戏进程窗口的对象，里面封装了丰富的方法、游戏数据
local success = obj:success()
-- 如果这里返回true,就证明绑定游戏成功，可以进行后面的操作了
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

- 获取角色周围npc对象列表
```lua
local npclist = obj:GetNpcList(isCreature)
-- 参数 isCreature(bool): 是否查询对象的物种类型,如果为true将会返回对象的物种编号，此操作较耗时 
-- 返回值（list<table>）：返回玩家附近的所有npc对象列表，属性如下：
-- table['obj'](number): npc对象在内存中的地址
-- table['guid'](number): npc对象的世界唯一标识
-- table['uid'](number): npc对象的唯一标识
-- table['x'](number): npc对象当前x坐标
-- table['y'](number): npc对象当前y坐标
-- table['z'](number): npc对象当前z坐标
-- table['hp'](int): npc对象当前血量
-- table['maxhp'](int): npc对象最大血量
-- table['mp'](int): npc对象当前蓝量
-- table['maxmp'](int): npc对象最大蓝量
-- table['target'](number): npc对象当前目标的对象内存地址
-- table['combat'](bool): npc对象当前战斗状态
-- table['creatureType'](int): npc对象的物种编号
-- table['type'](int): npc对象的类型ID
-- table['name'](string): npc对象的名字
```

- 更新npc信息
```lua
local npc = obj:UpdateNpcInfo(int p)
-- 说明：更新特定对象的信息
-- 参数 p: npc的对象地址
-- 返回值 属性如下：
-- table['obj'](number): npc对象在内存中的地址
-- table['guid'](number): npc对象的世界唯一标识
-- table['uid'](number): npc对象的唯一标识
-- table['x'](number): npc对象当前x坐标
-- table['y'](number): npc对象当前y坐标
-- table['z'](number): npc对象当前z坐标
-- table['hp'](int): npc对象当前血量
-- table['maxhp'](int): npc对象最大血量
-- table['mp'](int): npc对象当前蓝量
-- table['maxmp'](int): npc对象最大蓝量
-- table['target'](number): npc对象当前目标的对象内存地址
-- table['combat'](bool): npc对象当前战斗状态
-- table['creatureType'](int): npc对象的物种编号
-- table['type'](int): npc对象的类型ID
-- table['name'](string): npc对象的名字
```

- 根据NPC的类型ID来获取角色周围对应的对象列表
```lua
local npclist = obj:GetNpcListById(int npcType)
-- 参数：npcType(int): NPC的类型ID，每一个种类的NPC都有自己特定的类型ID，如所有的野猪类型都是9，如果无法确认，可以在GetNpcList()获取所有的NPC信息来看，对应'type' 属性。
-- 返回值（list<table>）：返回玩家附近的所有npc对象列表，属性如下：
-- table['obj'](number): npc对象在内存中的地址
-- table['guid'](number): npc对象的世界唯一标识
-- table['uid'](number): npc对象的唯一标识
-- table['x'](number): npc对象当前x坐标
-- table['y'](number): npc对象当前y坐标
-- table['z'](number): npc对象当前z坐标
-- table['hp'](int): npc对象当前血量
-- table['maxhp'](int): npc对象最大血量
-- table['mp'](int): npc对象当前蓝量
-- table['maxmp'](int): npc对象最大蓝量
-- table['target'](number): npc对象当前目标的对象内存地址
-- table['combat'](bool): npc对象当前战斗状态
-- table['creatureType'](int): npc对象的物种编号
-- table['type'](int): npc对象的类型ID
-- table['name'](string): npc对象的名字
```

- 根据NPC的类型ID来获取角色周围最近的NPC
```lua
local npclist = obj:GetNpcByIdAndDis(int npcType)
-- 参数：npcType(int): NPC的类型ID，每一个种类的NPC都有自己特定的类型ID，如所有的野猪类型都是9，如果无法确认，可以在GetNpcList()获取所有的NPC信息来看，对应'type' 属性。
-- 返回值 （table）：返回玩家附近的所有npc对象列表，属性如下，如果obj属性小于等于0，视为未找到：
-- table['obj'](number): npc对象在内存中的地址
-- table['guid'](number): npc对象的世界唯一标识
-- table['uid'](number): npc对象的唯一标识
-- table['x'](number): npc对象当前x坐标
-- table['y'](number): npc对象当前y坐标
-- table['z'](number): npc对象当前z坐标
-- table['hp'](int): npc对象当前血量
-- table['maxhp'](int): npc对象最大血量
-- table['mp'](int): npc对象当前蓝量
-- table['maxmp'](int): npc对象最大蓝量
-- table['target'](number): npc对象当前目标的对象内存地址
-- table['combat'](bool): npc对象当前战斗状态
-- table['creatureType'](int): npc对象的物种编号
-- table['type'](int): npc对象的类型ID
-- table['name'](string): npc对象的名字
```

- 根据NPC的类型ID和坐标来获取指定坐标周围最近的NPC
```lua
local npclist = obj:GetNpcByIdAndDisEx(int npcType, number x, number y)
-- 参数：npcType(int): NPC的类型ID，每一个种类的NPC都有自己特定的类型ID，如所有的野猪类型都是9，如果无法确认，可以在GetNpcList()获取所有的NPC信息来看，对应'type' 属性。
-- 参数 x,y：指定的坐标
-- 返回值 （table）：返回玩家附近的所有npc对象列表，属性如下，如果obj属性小于等于0，视为未找到：
-- table['obj'](number): npc对象在内存中的地址
-- table['guid'](number): npc对象的世界唯一标识
-- table['uid'](number): npc对象的唯一标识
-- table['x'](number): npc对象当前x坐标
-- table['y'](number): npc对象当前y坐标
-- table['z'](number): npc对象当前z坐标
-- table['hp'](int): npc对象当前血量
-- table['maxhp'](int): npc对象最大血量
-- table['mp'](int): npc对象当前蓝量
-- table['maxmp'](int): npc对象最大蓝量
-- table['target'](number): npc对象当前目标的对象内存地址
-- table['combat'](bool): npc对象当前战斗状态
-- table['creatureType'](int): npc对象的物种编号
-- table['type'](int): npc对象的类型ID
-- table['name'](string): npc对象的名字
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

- 获取角色背包物品列表
```lua
local bplist,num = obj:GetBagItemList(bool que)
-- 参数 que : 是否获取物品的品质（灰色、绿色、蓝色等），如果为true 会比较耗时反之较快。
-- 返回值 bplist（list<table>）：返回角色背包里面的物品信息，属性如下：
-- table['obj'](number): 背包物品对象在内存中的地址
-- table['id'](int): 背包物品对象的id
-- table['name'](string): 背包物品对象的名字
-- table['qua'](int): 背包物品对象的品质（0灰色、1白色、2绿色、3蓝色、4紫色、5橙色）
-- table['num'](int): 背包物品对象堆叠数量
-- 返回值 num（int）: 角色背包余剩格子数量
```

- 获取角色装备信息列表
```lua
local equipList= obj:GetEquipList()
-- 返回值 equipList（list<table>）：返回角色穿在身上装备的信息，属性如下：
-- table['obj'](number): 装备对象在内存中的地址
-- table['id'](int): 装备对象的id
-- table['name'](string): 装备对象的名字
-- table['durability'](number): 装备对象的当前耐久度
-- table['durability_max'](number): 装备对象的最大耐久度
-- table['itemQua'](number): ？？？
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

- 根据控件ID查找控件
```lua
local control = obj:GetControlById(int id)
-- 参数： id 控件ID
-- 返回值（注意，这里返回的是单个对象）（table）：返回找到的控件对象，属性如下：
-- table['obj'](number): 控件对象在内存中的地址
-- table['id'](int): 控件ID
-- table['name'](string): 控件名称（这是在游戏UI框架内的名称，不是我们看到的名称）
-- table['title'](string): 控件标题（这是我们在游戏内看到的控件名字，例如：接受、确定 等）
```

- 根据控件名字查找控件
```lua
local control = obj:GetControlByName(strig name)
-- 参数 name: 控件的名字（注意是名字，要和标题有区分，游戏里能看到的不是名字，是标题）
-- 返回值（注意，这里返回的是单个对象）（table）：返回找到的控件对象，属性如下：
-- table['obj'](number): 控件对象在内存中的地址
-- table['id'](int): 控件ID
-- table['name'](string): 控件名称（这是在游戏UI框架内的名称，不是我们看到的名称）
-- table['title'](string): 控件标题（这是我们在游戏内看到的控件名字，例如：接受、确定 等）
```

- 根据控件标题模糊查找控件
```lua
local control = obj:GetControlByTitle(strig title)
-- 参数 title: 控件的标题（注意是标题，游戏里能看到按钮上的文字）
-- 返回值（注意，这里返回的是个列表）（list<table>）：返回前UI显示的控件列表，属性如下：
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

- 右键点击控件
```lua
obj:RightClickControl(int p)
-- 说明：右键点击游戏内控件
-- 参数 p: 控件的对象地址
-- 无返回值
```

- 控件写入字符串
```lua
obj:WriteControl(int p, string str)
-- 说明：对游戏内的控件输入框输入文本
-- 参数 p: 控件的对象地址
-- 参数 str: 输入的内容
-- 无返回值
```

- 获取登录界面玩家数量 
```lua
local num = obj:GetLoginPlayerNum()
-- 返回值（int）：获取登录界面玩家数量 
```

- 设置窗口大小
```lua
obj:SetThisWindowSize(int w, int h)
-- 参数 w,h(int)：窗口的宽、高
-- 无返回值
```

- 键盘按键
```lua
obj:PressKeyboard(int key, int time)
-- 参数 key : 按键代码，参考：https://blog.csdn.net/weixin_38061311/article/details/99938426
-- 参数 time： 按下多久（毫秒）
-- 无返回值
```

- 鼠标点击左键
```lua
obj:MouseClickL(int x, int y)
-- 说明：此函数会激活窗口，但是很快
-- 参数 x,y (int): 点击的位置，这里的位置是指窗口的相对坐标，不需要计算屏幕坐标
-- 无返回值
```

- 鼠标点击右键
```lua
obj:MouseClickR(int x, int y)
-- 说明：此函数会激活窗口，但是很快
-- 参数 x,y (int): 点击的位置，这里的位置是指窗口的相对坐标，不需要计算屏幕坐标
-- 无返回值
```

- 打开点击走路
```lua
obj:OpenClickToMove()
-- 说明：打开游戏内设置点击走路的功能，确保此功能打开才能走路
-- 无返回值
```

- 打开自动拾取
```lua
obj:OpenPickup()
-- 说明：打开游戏内设置的自动拾取功能
-- 无返回值
```

- 游戏当前状态
```lua
local state = obj:GetGameState()
-- 说明：游戏当前状态
-- 返回值: 1在游戏内 0:人物选择界面(或未知)  2:读蓝条（加载中）3账号未登录状态
```

- 改变玩家朝向
```lua
obj:ChangePlayerDir(number dir)
-- 参数：转向的角度
-- 无返回值
```

- 处理角色AFK暂离状态
```lua
obj:HandleAFK()
-- 说明：调用此方法可以自动检测、处理暂离状态，可以考虑周期性的调用此方法防止暂离
-- 无返回值
```

- 和目标交互
```lua
obj:PlayerInteraction(int p)
-- 说明：和目标交互
-- 参数 p: 目标的对象地址
-- 无返回值
```

- 设置玩家目标
```lua
obj:SetPlayerTarget(int p)
-- 说明：设置玩家目标
-- 参数 p: 目标的对象地址
-- 无返回值
```

- 玩家施法状态
```lua
local cast,sing = obj:GetSpellState()
-- 返回值 cast（bool） 是否正在施法
-- 返回值 sing（bool） 是否正在引导法术
```

- 商店商品列表
```lua
local goods = obj:GetGoodsList()
-- 说明：当玩家打开可以售卖物品的NPC时，这个方法可以读取出所有商品的ID
-- 返回值 list<int> 所有商品ID的列表
```

- 购买物品
```lua
obj:BuyGoods(int p, int goodsId, int num)
-- 参数 p(int): 商人NPC的对象地址（GetNpcList() 可遍历到）
-- 参数 goodsId(int): 商品的ID
-- 参数 num(int): 购买的数量
```

- 出售物品
```lua
obj:BuyGoods(int p, int pitem)
-- 参数 p(int):商人NPC的对象地址 (GetNpcList() 可遍历到)
-- 参数 pitem(int): 背包物品的对象地址（）
```

- 游戏内当前时间
```lua
local time = obj:GetTime()
-- 说明：获取游戏服务器当前的时间戳
-- 返回值 int 
```

- 角色所在地图ID
```lua
local id = obj:GetLocalId()
-- 说明：获取角色所在地图ID
-- 返回值 int 
```

- 角色所在大地图小地图名字
```lua
local localText,localMiniText = obj:GetMapText()
-- 说明：角色所在大地图小地图名字
-- 返回值 localText(string): 大地图名称
-- 返回值 localMiniText(string): 小地图名称
```

- 角色乘骑状态
```lua
local ride = obj:GetRideState()
-- 说明：角色乘骑状态
-- 返回值 ride(bool)
```

- 角色的技能冷却列表
```lua
local coolDownList = obj:GetCoolDownList()
-- 说明：角色的技能冷却列表
-- 返回值 list<table> 属性如下：
-- coolDownList['id'] : 冷却中技能ID
-- coolDownList['overTime'] : 冷却中技能冷却完毕时间（游戏内当前时间方法可以对应）
```

- 角色的buff列表
```lua
local buffList = obj:GetBuffList()
-- 说明：角色的buff列表
-- 返回值 list<int> : 角色的BUFFID
```

- 角色的Debuff列表
```lua
local debuffList = obj:GetPlayerDebuffList()
-- 说明：角色的debuff列表
-- 返回值 list<int> : 角色的debuffid
```

- 角色身上的金钱数
```lua
local money = obj:GetMoney()
-- 说明：身上的金钱数 单位是铜
-- 返回值 int
```

- 运行宏命令
```lua
obj:RunMacro(string macro)
-- 说明：运行宏命令 不适应太长，如果很长请分开多个语句运行
```

- 左键点击地面
```lua
obj:LeftClick(number x, number y)
-- 说明：左键点击地面,类似法师施放暴风雪的位置
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

- 角色信息
```lua
local name,serviceName,playerFactionGroup,playerClass = obj:GetPlayerInfo()
-- 说明：角色当前所在坐标信息
-- 返回值 name(string)名字 serviceName(string)服务器 playerFactionGroup(string)阵营（联盟、部落） playerClass(int)职业分类ID（）
```

- 角色战斗状态
```lua
local state = obj:GetPlayerState()
-- 说明：角色战斗状态
-- 返回值 bool 
```

- 角色目标
```lua
local pTarget = obj:GetPlayerTarget()
-- 说明：获取当前角色目标的对象地址
-- 返回值 int
```

- 拾取栏物品id列表
```lua
local itemList = obj:GetPickupList()
-- 说明：当我们杀死怪，拾取的时候会弹出一个拾取物品列表，这个方法可以列出这个列表里面的所有物品ID
-- 返回值 list<int>
```

- 角色是否在室外
```lua
local isOutDoor = obj:IsOutDoor()
-- 说明：角色是否在室外
-- 返回值 bool
```

- 角色队伍信息
```lua
local teams,isLeader = obj:GetTeamPlayerInfo()
-- 说明：获取角色队伍的信息，如果放回nil就没在队伍里
-- 返回值 list<table>，队伍信息的列表，属性如下:
-- table['obj']（int）: 队友的对象地址
-- table['name'](string): 队友的名字（不含服务器名）
-- table['online'](bool): 队友是否在线
-- 返回值 isLeader:  当前角色在队伍中是否是队长
```

