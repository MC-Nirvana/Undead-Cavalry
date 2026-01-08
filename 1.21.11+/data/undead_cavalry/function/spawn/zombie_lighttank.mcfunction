# --- 1. 转换判定 (5% 几率) ---
execute as @e[type=minecraft:panda,tag=!uc_processed] store result score @s uc_status run random value 1..100
execute as @e[type=minecraft:panda,tag=!uc_processed,scores={uc_status=1..5}] run tag @s add uc_tank_convert

# --- 2. 召唤好斗熊猫坦克 (红色眼睛) ---
# 强制设定基因位为 aggressive (好斗)
execute as @e[tag=uc_tank_convert] at @s run summon minecraft:panda ~ ~ ~ {MainGene:"aggressive",HiddenGene:"aggressive",Tags:["uc_processed","uc_mount_active"],Passengers:[{id:"minecraft:zombie",Tags:["uc_tank_rider","uc_random_enchant"]}]}

# --- 3. 基础装备赋予 ---
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant] run item replace entity @s weapon.mainhand with minecraft:iron_sword
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant] run item replace entity @s armor.chest with minecraft:iron_chestplate

# --- 4. 坦克武器附魔 (剑: 锋利V, 火焰附加II, 击退II, 横扫之刃III, 耐久III) ---

# [锋利 V] 30% 几率
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant,scores={uc_status=1..30}] store result score @s uc_status run random value 1..5
execute as @e[tag=uc_tank_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":1},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=2}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":2},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=3}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":3},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=4}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":4},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=5}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sharpness":5},add:true}

# [横扫之刃 Sweeping Edge III] 25% 几率
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant,scores={uc_status=1..25}] store result score @s uc_status run random value 1..3
execute as @e[tag=uc_tank_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sweeping_edge":1},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=2}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sweeping_edge":2},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=3}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:sweeping_edge":3},add:true}

# [火焰附加 II] 20% 几率
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant,scores={uc_status=1..20}] store result score @s uc_status run random value 1..2
execute as @e[tag=uc_tank_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:fire_aspect":1},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=2}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:fire_aspect":2},add:true}

# [击退 II] 20% 几率
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_tank_rider,tag=uc_random_enchant,scores={uc_status=1..20}] store result score @s uc_status run random value 1..2
execute as @e[tag=uc_tank_rider,scores={uc_status=1}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:knockback":1},add:true}
execute as @e[tag=uc_tank_rider,scores={uc_status=2}] run item modify entity @s weapon.mainhand {function:"minecraft:set_enchantments",enchantments:{"minecraft:knockback":2},add:true}

# --- 5. 通用附魔 (胸甲) ---
# [保护 IV]
execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..25}] run item modify entity @s armor.chest {function:"minecraft:set_enchantments",enchantments:{"minecraft:protection":4},add:true}

# --- 6. 全员药水池 (6种独立判定) ---
execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..15}] run effect give @s minecraft:invisibility infinite 0 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..25}] run effect give @s minecraft:speed infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..20}] run effect give @s minecraft:absorption infinite 4 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..30}] run effect give @s minecraft:strength infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..40}] run effect give @s minecraft:resistance infinite 1 true

execute as @e[tag=uc_random_enchant] store result score @s uc_status run random value 1..100
execute as @e[tag=uc_random_enchant,scores={uc_status=1..20}] run effect give @s minecraft:wind_charged infinite 0 true

# --- 7. 清理与收尾 ---
tag @e[tag=uc_random_enchant] remove uc_random_enchant
tag @e[tag=uc_mount_active] remove uc_mount_active
execute as @e[tag=uc_tank_convert] run tp @s ~ -64 ~
execute as @e[tag=uc_tank_convert] run kill @s
tag @e[type=minecraft:panda,tag=!uc_processed] add uc_processed
schedule function undead_cavalry:spawn/zombie_lighttank 30t