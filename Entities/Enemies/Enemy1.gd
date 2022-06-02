extends Unit

onready var player := get_node("../../Player/Player")

func _physics_process(_delta):
	if is_instance_valid(player) && global_position.distance_to(player.global_position) > 3:
		velocity = global_position.direction_to(player.global_position) * 120
	else:
		velocity = Vector2.ZERO
