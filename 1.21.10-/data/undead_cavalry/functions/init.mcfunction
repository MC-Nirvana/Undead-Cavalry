# undead_cavalry:init
# -------------------------------
# 1. scoreboard 初始化
# -------------------------------
scoreboard objectives add rand dummy
scoreboard objectives add time_since_sleep dummy

# -------------------------------
# 2. 标签清理
# -------------------------------
tag @a remove in_forest
tag @a remove in_plains
tag @a remove in_desert
tag @a remove in_jungle
tag @a remove in_bamboo_forest

tag @e[tag=undead_rider] remove undead_rider
tag @e[tag=undead_mount] remove undead_mount
tag @e[tag=phantom_special] remove phantom_special

# -------------------------------
# 3. 初始随机数
# -------------------------------
scoreboard players set #rand rand 0
