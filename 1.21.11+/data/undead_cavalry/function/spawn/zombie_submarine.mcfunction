# --- 1. 转换判定 (10% 几率，且必须手持三叉戟) ---
execute as @e[type=minecraft:drowned,tag=!uc_processed] if items entity @s weapon.mainhand minecraft:trident store result score @s uc_status run random value 1..100
execute as @e[type=minecraft:drowned,tag=!uc_processed,scores={uc_status=1..10}] run tag @s add uc_sub_convert

# --- 2. 召唤 1.21.11 原生载具 (鹦鹉螺僵尸) 与 溺尸骑兵 ---
execute as @e[tag=uc_sub_convert] at @s run summon minecraft:zombie_nautilus ~ ~ ~ {Tags:["uc_processed","uc_mount_active"],Passengers:[{id:"minecraft:drowned",Tags:["uc_sub_rider","uc_random_enchant"]}]}

# --- 3. 基础装备与初始化 ---
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] run item replace entity @s weapon.mainhand with minecraft:trident
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] run item replace entity @s armor.chest with minecraft:iron_chestplate

# --- 4. 三叉戟附魔池 (穿刺V, 忠诚III, 引雷I, 激流III, 耐久III) ---
# [穿刺 V] 30% 几率
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant,scores={uc_status=1..30}] store result score @s uc_status run random value 1..5
execute as @e[tag=uc_sub_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:impaling":1},add:true}
execute as @e[tag=uc_sub_rider,scores={uc_status=5}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:impaling":5},add:true}

# [忠诚 III] 25% 几率
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant,scores={uc_status=1..25}] store result score @s uc_status run random value 1..3
execute as @e[tag=uc_sub_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:loyalty":1},add:true}
execute as @e[tag=uc_sub_rider,scores={uc_status=3}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:loyalty":3},add:true}

# [激流 III] 15% 几率
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant,scores={uc_status=1..15}] store result score @s uc_status run random value 1..3
execute as @e[tag=uc_sub_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:riptide":1},add:true}
execute as @e[tag=uc_sub_rider,scores={uc_status=3}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:riptide":3},add:true}

# [引雷 I] 15% 几率
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_sub_rider,scores={uc_status=1..15}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:channeling":1},add:true}

# --- 5. 通用附魔 ---
# [耐久 III] 30% 几率
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant,scores={uc_status=1..30}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:unbreaking":3},add:true}
# [保护 IV] 25% 几率
execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..25}] run item modify entity @s armor.chest {function:"minecraft:set_enchantments",enchantments:{"minecraft:protection":4},add:true}

# --- 6. 药水池 (幽灵潜艇特化) ---
# [幽灵化] 15% 几率同时作用于载具
execute as @e[tag=uc_sub_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_sub_rider,scores={uc_status=1..15}] at @s run effect give @s invisibility infinite 0 true
execute as @e[tag=uc_sub_rider,scores={uc_status=1..15}] at @s run effect give @e[tag=uc_mount_active,distance=..1,limit=1] invisibility infinite 0 true

# [其他 5 种独立判定]
execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..25}] run effect give @s speed infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..20}] run effect give @s strength infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..40}] run effect give @s resistance infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..20}] run effect give @s absorption infinite 4 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..20}] run effect give @s conduit_power infinite 0 true

# --- 7. 清理与收尾 ---
tag @e[tag=uc_random_enchant] remove uc_random_enchant
tag @e[tag=uc_mount_active] remove uc_mount_active
execute as @e[tag=uc_sub_convert] run tp @s ~ -64 ~
execute as @e[tag=uc_sub_convert] run kill @s
tag @e[type=minecraft:drowned,tag=!uc_processed] add uc_processed
schedule function undead_cavalry:spawn/zombie_submarine 35t