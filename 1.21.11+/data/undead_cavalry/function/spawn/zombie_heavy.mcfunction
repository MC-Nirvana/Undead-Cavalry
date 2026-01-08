# --- 1. 骆驼转换判定 ---
execute as @e[type=minecraft:camel,tag=!uc_processed] store result score @s uc_status run random value 1..100
execute as @e[type=minecraft:camel,tag=!uc_processed,scores={uc_status=1..8}] run tag @s add uc_heavy_convert

# --- 2. 召唤重装骆驼 ---
execute as @e[tag=uc_heavy_convert] at @s run summon minecraft:camel ~ ~ ~ {Tags:["uc_processed","uc_mount_temp"],Passengers:[{id:"minecraft:parched",Tags:["uc_heavy_archer","uc_random_enchant"]},{id:"minecraft:zombie",Tags:["uc_heavy_rider","uc_random_enchant"]}]}

# --- 3. 基础装备赋予 ---
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant] run item replace entity @s weapon.mainhand with minecraft:iron_spear
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant] run item replace entity @s weapon.offhand with minecraft:shield
execute as @e[tag=uc_heavy_archer,tag=uc_random_enchant] run item replace entity @s weapon.mainhand with minecraft:bow
execute as @e[tag=uc_random_enchant] run item replace entity @s armor.chest with minecraft:iron_chestplate

# --- 4. 骑手 (铁矛) 附魔 (穷举法避错) ---
# [锋利 V] 30% 概率
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant,scores={uc_status=1..30}] store result score @s uc_status run random value 1..5
execute as @e[tag=uc_heavy_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":1},add:true}
execute as @e[tag=uc_heavy_rider,scores={uc_status=2}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":2},add:true}
execute as @e[tag=uc_heavy_rider,scores={uc_status=3}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":3},add:true}
execute as @e[tag=uc_heavy_rider,scores={uc_status=4}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":4},add:true}
execute as @e[tag=uc_heavy_rider,scores={uc_status=5}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":5},add:true}

# [突进 III] 20% 概率
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant,scores={uc_status=1..20}] store result score @s uc_status run random value 1..3
execute as @e[tag=uc_heavy_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:breach":1},add:true}
execute as @e[tag=uc_heavy_rider,scores={uc_status=2}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:breach":2},add:true}
execute as @e[tag=uc_heavy_rider,scores={uc_status=3}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:breach":3},add:true}

# --- 5. 射手 (弓) 附魔 ---
# [力量 V] 30% 概率
execute as @e[tag=uc_heavy_archer,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_heavy_archer,tag=uc_random_enchant,scores={uc_status=1..30}] store result score @s uc_status run random value 1..5
execute as @e[tag=uc_heavy_archer,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:power":1},add:true}
execute as @e[tag=uc_heavy_archer,scores={uc_status=5}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:power":5},add:true}

# [火矢 & 无限] 15% 概率
execute as @e[tag=uc_heavy_archer,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_heavy_archer,scores={uc_status=1..15}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:flame":1},add:true}
execute as @e[tag=uc_heavy_archer,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_heavy_archer,scores={uc_status=1..15}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:infinity":1},add:true}

# --- 6. 通用 (盾牌/胸甲) 附魔 ---
# [耐久 III] (应用于矛和盾)
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant,scores={uc_status=1..30}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:unbreaking":3},add:true}
execute as @e[tag=uc_heavy_rider,tag=uc_random_enchant,scores={uc_status=1..30}] run item modify entity @s weapon.offhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:unbreaking":3},add:true}

# [保护 IV]
execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..25}] run item modify entity @s armor.chest {function:"minecraft:set_enchantments",enchantments:{"minecraft:protection":4},add:true}

# --- 7. 药水池 (独立判定，解决 uc_level 报错) ---
execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..30}] run effect give @s minecraft:speed infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..20}] run effect give @s minecraft:strength infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..40}] run effect give @s minecraft:resistance infinite 1 true

# --- 8. 清理 ---
tag @e[tag=uc_random_enchant] remove uc_random_enchant
tag @e[tag=uc_mount_temp] remove uc_mount_temp
execute as @e[tag=uc_heavy_convert] run tp @s ~ -64 ~
execute as @e[tag=uc_heavy_convert] run kill @s
tag @e[type=minecraft:camel,tag=!uc_processed] add uc_processed
schedule function undead_cavalry:spawn/zombie_heavy 25t