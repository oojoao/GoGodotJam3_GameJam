extends State

var direction : Vector2
var friction : float

func enter() -> void:
	friction = 3.0
	direction = unit.global_position.direction_to(unit.get_global_mouse_position())
	unit.stats.tags.append("invincible")

func exit() -> void:
	unit.stats.tags.erase("invincible")
	
func physics_update(_delta) -> void:
	friction = lerp(friction, 0, 0.05)
	unit.velocity = direction * unit.stats.movement_speed * friction
	
	var colliding_enemy = unit.hitbox.get_colliding_enemy()
	print(colliding_enemy)
	if colliding_enemy != null:
		colliding_enemy.queue_free()
		friction = 0
		unit.stats.add_bonus("damage", 1.0)
		print(unit.stats.damage)
	
	if friction <= 0.3:
		state_machine.transition_to("Walking")
