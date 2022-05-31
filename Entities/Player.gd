extends Unit

func _physics_process(_delta):
	velocity = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	).normalized() * 250
	
func _input(event):
	if event is InputEventMouseButton and event.is_action_pressed("fire"):
		var newProjectile : Projectile = projectile.instance()
		newProjectile.direction = global_position.direction_to(event.global_position)
		newProjectile.global_position = global_position
		get_parent().add_child(newProjectile)
		newProjectile.ally = ally
