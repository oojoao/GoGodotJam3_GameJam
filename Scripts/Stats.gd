class_name Stats
extends Node

signal no_health()

var base_stats := {}

var health : float
var damage : float
var movement_speed : float
var attack_speed : float
var projectile_speed : float

var level : int
var mana : float
var manaToNext : float

var current_health : float
var tags := []

func setup_base_stats() -> void:
	for stat in ["health", "damage", "movement_speed", "attack_speed", "projectile_speed"]:
		base_stats[stat] = {
			"base" : 50,
			"additive_bonus" : 0,
			"multiplicative_bonus" : 0
		}
	
	base_stats["damage"]["base"] = 3
	base_stats["movement_speed"]["base"] = 250
	base_stats["attack_speed"]["base"] = 0.8
	base_stats["projectile_speed"]["base"] = 300
	
	
func set_final_stat(var stat : String) -> void:
	var base_stat = base_stats[stat]
	self.set(stat, (base_stat["base"] + base_stat["additive_bonus"]) * (1 + base_stat["multiplicative_bonus"]))
	if stat == "health":
		current_health = health
	elif stat == "attack_speed":
		$AttackSpeedTimer.wait_time = (1/attack_speed)

func add_bonus(var stat : String, var amount, var isAdditive := true) -> void:
	var base_stat = base_stats[stat]
	if isAdditive:
		base_stat["additive_bonus"] += amount
	else:
		base_stat["multiplicative_bonus"] += amount
	set_final_stat(stat)

func deal_damage(var amount : float) -> void:
	current_health -= amount
	print(current_health)
	if current_health <= 0:
		emit_signal("no_health")

func _ready():
	setup_base_stats()
	for stat in base_stats:
		set_final_stat(stat)
