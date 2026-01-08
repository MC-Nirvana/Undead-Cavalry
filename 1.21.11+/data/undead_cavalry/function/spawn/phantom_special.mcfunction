# --- 1. 觉醒/转换逻辑 ---
# 判定逻辑：玩家 3 天不睡觉(72000刻)，且身边 32 格内有未处理的自然幻翼
execute as @a[scores={uc_sleep_timer=72000..}] at @s as @e[type=phantom,tag=!uc_processed,distance=..32] run tag @s add uc_phantom_strike

# 为觉醒的幻翼赋予数值增强 (速度与抗性)
execute as @e[tag=uc_phantom_strike,tag=!uc_processed] run effect give @s minecraft:speed infinite 2 true
execute as @e[tag=uc_phantom_strike,tag=!uc_processed] run effect give @s minecraft:resistance infinite 4 true
execute as @e[tag=uc_phantom_strike,tag=!uc_processed] run tag @s add uc_processed

# --- 2. 命中/自爆触发判定 ---
# 当特攻幻翼接近玩家 (距离 < 2.1格) 时，判定为攻击命中，标记自爆
execute as @e[tag=uc_phantom_strike] at @s if entity @p[distance=..2.1] run tag @s add uc_exploding

# --- 3. 自爆执行 (已舍弃天气判定，统一使用标准自爆) ---
# 召唤一个立即爆炸的苦力怕 (ExplosionRadius 为爆炸半径)
execute as @e[tag=uc_exploding] at @s run summon minecraft:creeper ~ ~ ~ {Fuse:0,ignited:1b,ExplosionRadius:3b}

# --- 4. 分裂逻辑 (生成两个新子体，子体不带 uc_processed 以便循环检测) ---
execute as @e[tag=uc_exploding] at @s run summon minecraft:phantom ~0.5 ~ ~ {Tags:["uc_phantom_strike"]}
execute as @e[tag=uc_exploding] at @s run summon minecraft:phantom ~-0.5 ~ ~ {Tags:["uc_phantom_strike"]}

# --- 5. 清理原实体与音效 ---
# 修复 playsound 语法，确保符合 1.21.11 的参数顺序
execute as @e[tag=uc_exploding] at @s run playsound minecraft:entity.generic.explode hostile @a ~ ~ ~ 1.0 1.0 1.0
execute as @e[tag=uc_exploding] run tp @s ~ -64 ~
execute as @e[tag=uc_exploding] run kill @s

# --- 6. 循环控制 ---
schedule function undead_cavalry:spawn/phantom_special 20t