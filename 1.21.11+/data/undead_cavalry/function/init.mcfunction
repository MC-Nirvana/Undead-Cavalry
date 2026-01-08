# --- 1. 计分板初始化 ---
# 只在加载时运行一次，确保记分项存在
scoreboard objectives add uc_sleep_timer minecraft.custom:minecraft.time_since_rest
scoreboard objectives add uc_status dummy

# --- 2. 启动逻辑循环 ---
# 只需要在这里点火一次，之后各脚本会靠自己的 schedule 维持运行
schedule function undead_cavalry:spawn/mini_zombie 20t
schedule function undead_cavalry:spawn/zombie_heavy 25t
schedule function undead_cavalry:spawn/zombie_lighttank 30t
schedule function undead_cavalry:spawn/zombie_submarine 35t
schedule function undead_cavalry:spawn/phantom_special 40t

# --- 3. 提示 ---
# 这样 reload 之后只会看到一次提示
tellraw @a {"text":"[Undead Cavalry] 1.21.11 亡灵骑兵系统已就绪。","color":"gold"}