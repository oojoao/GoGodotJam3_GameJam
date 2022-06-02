extends State

func physics_update(_delta):
	unit.velocity = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized() * unit.stats.movement_speed
	
	if Input.is_action_pressed("fire"):
		if unit.stats.get_node("AttackSpeedTimer").is_stopped():
			var newProjectile : Projectile = unit.projectile.instance()
			newProjectile.direction = unit.global_position.direction_to(unit.get_global_mouse_position())
			newProjectile.global_position = unit.global_position
			newProjectile.damage = unit.stats.damage
			newProjectile.speed = unit.stats.projectile_speed
			unit.get_parent().add_child(newProjectile)
			newProjectile.ally = unit.ally
			unit.stats.get_node("AttackSpeedTimer").start()
	
	if Input.is_action_just_pressed("dash"):
#		if unit.stats.mana >= unit.stats.manaToNext:
		state_machine.transition_to("Dashing")
			
