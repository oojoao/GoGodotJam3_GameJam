extends Area2D

onready var unit := get_parent()

func get_colliding_enemy() -> Unit:
	var overlap = get_overlapping_areas()
	if overlap.size() > 0:
		for area in overlap:
			if area.get("unit") is Unit && area.get("unit").ally != unit.ally:
				return area.get("unit")
		return null
	else:
		return null
